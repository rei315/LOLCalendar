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
    
    private var cells = BehaviorRelay<[LOLBracketElement]>(value: [])
    
    private var tmpData = BehaviorSubject<LOLBracket>(value: [])
    
    let disposeBag = DisposeBag()
    
    init(coordinator: SceneCoordinatorType, model: CalendarListModel = CalendarListModel()){
        
        let eSport = model.getLOLEsport()
        let allBranckets = eSport
            .map { $0.tournamentID }
            .flatMap(model.getBrancket)
            .toArray()
            .asObservable()
            .map( { (items) -> LOLBracket in
                return items.sorted { (bracket1, bracket2) -> Bool in
                    return bracket1.scheduledAt > bracket2.scheduledAt
                }
            })
        
        allBranckets
            .bind(to: cells)
            .disposed(by: disposeBag)

            
        self.cellData = cells
            .map(model.parseBrancket)
            .asDriver(onErrorDriveWith: .empty())
            
        
        super.init(sceneCoordinator: coordinator)
    }
    
    
}
