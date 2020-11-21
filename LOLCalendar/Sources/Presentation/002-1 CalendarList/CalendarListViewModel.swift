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
        
        let _ = ids
            .map { data -> Int? in
                if data.0 == -1 {
                    return nil
                }
                if !data.1 {
                    return data.2
                } else {
                    return nil
                }
            }
            .filterNil()
            .map { $0 + 1 }
            .trackActivity(activityIndicator)
            .bind(to: nextPageNum)
            .disposed(by: disposeBag)
            
            
        
//        let fetchList = shouldMoreFatch
//            .distinctUntilChanged()
//            .map { $0 + 1 }
//            .flatMap { page -> Observable<(Int, Bool, Int)> in
//                model.fetchMoreData(league: leagueType, page: page)
//            }
//            .catchError({ (error) -> Observable<(Int, Bool, Int)> in
//                return .just((-1,false,-1))
//            })
//            .asObservable()
//            .map { $0.0 }
//            .flatMap(model.getLOLBracket)
//            .catchError({ (error) -> Observable<LOLCalendar> in
//                let tmpCalendar = LOLCalendar()
//                return .just(tmpCalendar)
//            })
//            .trackActivity(activityIndicator)
//            .toArray()
//            .asObservable()
//            .map( { (items) -> [LOLCalendar] in
//                return items.sorted { (bracket1, bracket2) -> Bool in
//                    return bracket1.scheduleAt > bracket2.scheduleAt
//                }
//            })
//            .share()
            bracketList
                .filterEmpty()
                .bind(to: cells)
                .disposed(by: disposeBag)
        
//        Observable
//            .merge(
//                bracketList,
//                fetchList
//            )
//            .filterEmpty()
//            .scan([]) { prev, newList in
//                return newList.isEmpty ? [] : prev + newList
//            }
//            .bind(to: cells)
//            .disposed(by: disposeBag)
        
//        self.cellData = cells
//            .map(model.parseBracket)
//            .asDriver(onErrorDriveWith: .empty())
    
        super.init(sceneCoordinator: coordinator)
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
                .subscribe(onNext: { list in
                    let new = self.cells.value + list
                    self.cells.accept(new)
                    self.lastPageNum.onNext(lastPage+1)
                })
                .disposed(by: self.disposeBag)
            
            let _ = ids
                .map { data -> Int? in
                    if data.0 == -1 {
                        return nil
                    }
                    if !data.1 {
                        return data.2
                    } else {
                        return nil
                    }
                }
                .filterNil()
                .trackActivity(self.activityIndicator)
                .bind(to: self.nextPageNum)
                .disposed(by: self.disposeBag)
            return true
        } catch {
            return false
        }
    }
}
