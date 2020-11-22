//
//  CalendarListViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import Action

protocol CalendarModelBindable {
    var viewWillAppear: PublishSubject<Void> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    
//    var cellData: Driver<[CalendarListTableViewCell.Data]> { get }
//    var reloadList: Signal<Void> { get }
//    var errorMessage: Signal<String> { get }
}

class CalendarListViewModel: CommonViewModel, CalendarModelBindable {
    
//    var cellData: Driver<[CalendarListTableViewCell.Data]>
    let viewWillAppear = PublishSubject<Void>()
    let willDisplayCell = PublishRelay<IndexPath>()
//    let reloadList: Signal<Void>()
//    let errorMessage: Signal<String>()
    
    var cells = BehaviorRelay<[LOLCalendar]>(value: [])
    var nextPageNum = BehaviorSubject<Int>(value: 1)
    var lastPageNum = BehaviorSubject<Int>(value: 1)
//    var pageNum: Int = 1
    
    private let activityIndicator = ActivityIndicator()
    
    var isRunning: Observable<Bool> {
        return activityIndicator.asObservable()
    }
    
    let disposeBag = DisposeBag()
    
    var model: CalendarListModel
    let leagueType: Int
    
    lazy var detailAction: Action<LOLCalendar, Void> = {
        return Action { calendarData in
            let detailViewModel = CalendarDetailViewModel(coordinator: self.sceneCoordinator, data: calendarData)            
            let calendarDetailScene = Scene.calendarDetail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: calendarDetailScene, using: .push, animated: true).asObservable().map { _ in }
        }
    }()
    
    init(coordinator: SceneCoordinatorType, leagueType: Int, model: CalendarListModel = CalendarListModel()){
        self.model = model
        
        self.leagueType = leagueType
        let ids = model.getLOLLeagueTournamentId(league: leagueType)
            .catchError({ (error) -> Observable<(Int, Bool, Int)> in
                return .just((-1,false,-1))
            })
            .share()
            .trackActivity(activityIndicator)
        
        let bracketList = ids
            .flatMap {
                model.getLOLBracket(id: $0.0)
            }
            .catchError({ (error) -> Observable<LOLCalendar> in
                let tmpCalendar = LOLCalendar()
                return .just(tmpCalendar)
            })
            .toArray()
            .asObservable()
            .map( { (items) -> [LOLCalendar] in
                return items.sorted { (bracket1, bracket2) -> Bool in
                    return bracket1.scheduleAt > bracket2.scheduleAt
                }
            })
            .share()
            .trackActivity(activityIndicator)

            bracketList
                .filterEmpty()
                .bind(to: cells)
                .disposed(by: disposeBag)

        super.init(sceneCoordinator: coordinator)
        
        let _ = ids
            .map { data -> Int? in
                if data.0 == -1 {
                    return nil
                }
                if !data.1 {
                    return data.2 + 1
                } else {
                    return nil
                }
            }
            .filterNil()
            .trackActivity(activityIndicator)
            .subscribe(onNext: { page in
                self.nextPageNum.onNext(page)
            })
            .disposed(by: disposeBag)
    }

    func updateList() -> Bool {
        do {
            let page = try self.nextPageNum.value()
            let lastPage = try self.lastPageNum.value()
            if (page == lastPage) { return false }
            
            let ids = self.model.fetchMoreData(league: self.leagueType, page: page)
                .catchError({ (error) -> Observable<(Int, Bool, Int)> in
                    self.nextPageNum.onNext(page-1)
                    return .just((-1,false,-1))
                })
                .share()
                .trackActivity(self.activityIndicator)
                            
            let _ = ids
                .flatMap {
                    self.model.getLOLBracket(id: $0.0)
                }
                .catchError({ (error) -> Observable<LOLCalendar> in
                    let tmpCalendar = LOLCalendar()
                    return .just(tmpCalendar)
                })
                .toArray()
                .asObservable()
                .map( { (items) -> [LOLCalendar] in
                    return items.sorted { (bracket1, bracket2) -> Bool in
                        return bracket1.scheduleAt > bracket2.scheduleAt
                    }
                })
                .trackActivity(self.activityIndicator)
                .subscribe(onNext: { lists in
                    var tmpList: [LOLCalendar] = []
                    for list in lists {
                        if !self.cells.value.contains(list) {
                            tmpList.append(list)
                        }
                    }
                    self.cells.accept(tmpList)
                    self.lastPageNum.onNext(lastPage+1)
                })
                .disposed(by: self.disposeBag)
            
            let _ = ids
                .take(1)
                .map { data -> Int? in
                    if data.0 == -1 {
                        return nil
                    }
                    if !data.1 {
                        return data.2 + 1
                    } else {
                        return nil
                    }
                }
                .filterNil()
                .trackActivity(self.activityIndicator)
                .subscribe(onNext: { page in
                    self.nextPageNum.onNext(page)
                })
                .disposed(by: self.disposeBag)
            return true
        } catch {
            return false
        }
    }
}
