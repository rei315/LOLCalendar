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

protocol CalendarModelBindable {
    var viewWillAppear: PublishSubject<Void> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    
    var cellData: Driver<[CalendarListTableViewCell.Data]> { get }
//    var reloadList: Signal<Void> { get }
//    var errorMessage: Signal<String> { get }
}

class CalendarListViewModel: CommonViewModel, CalendarModelBindable {
    
    let cellData: Driver<[CalendarListTableViewCell.Data]>
    let viewWillAppear = PublishSubject<Void>()
    let willDisplayCell = PublishRelay<IndexPath>()
//    let reloadList: Signal<Void>()
//    let errorMessage: Signal<String>()
    
    private var cells = BehaviorRelay<[LOLCalendar]>(value: [])
    
    let disposeBag = DisposeBag()
    
    init(coordinator: SceneCoordinatorType, model: CalendarListModel = CalendarListModel()){
        
        let ids = model.getLOLLeagueTournamentId()
            .share()
        
        let bracketList = ids
            .flatMap {
                model.getLOLBracket(id: $0.0)
            }
            .toArray()
            .asObservable()
            .map( { (items) -> [LOLCalendar] in
                return items.sorted { (bracket1, bracket2) -> Bool in
                    return bracket1.scheduleAt > bracket2.scheduleAt
                }
            })
            .share()
        
        let shouldMoreFatch = ids
            .map { data -> Int? in
                if !data.1 {
                    return data.2
                } else {
                    return nil
                }
            }
            .filterNil()
        
        let fetchList = shouldMoreFatch
            .distinctUntilChanged()
            .map { $0 + 1 }
            .flatMap(model.fetchMoreData)
            .asObservable()
            .map { $0.0 }
            .flatMap(model.getLOLBracket)
            .toArray()
            .asObservable()
            .map( { (items) -> [LOLCalendar] in
                return items.sorted { (bracket1, bracket2) -> Bool in
                    return bracket1.scheduleAt > bracket2.scheduleAt
                }
            })
            .share()
            
        Observable
            .merge(
                bracketList,
                fetchList
            )
            .scan([]) { prev, newList in
                return newList.isEmpty ? [] : prev + newList
            }
            .bind(to: cells)
            .disposed(by: disposeBag)
        
        self.cellData = cells
            .map(model.parseBracket)
            .asDriver(onErrorDriveWith: .empty())
    
        super.init(sceneCoordinator: coordinator)
    }
    
    
}
