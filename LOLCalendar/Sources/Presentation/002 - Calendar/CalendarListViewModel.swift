//
//  CalendarListViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import UIKit
import RxSwift
import RxCocoa

protocol CalendarModelBindable {
    var viewWillAppear: PublishSubject<Void> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    
    var cellData: Driver<[CalendarListTableViewCell.Data]> { get }
//    var reloadList: Signal<Void> { get }
//    var errorMessage: Signal<String> { get }
}

class CalendarListViewModel: CommonViewModel, CalendarModelBindable {
    
    let cellData: Driver<[CalendarListTableViewCell.Data]>    
    let viewWillAppear: PublishSubject<Void>
    let willDisplayCell: PublishRelay<IndexPath>
//    let reloadList: Signal<Void>
//    let errorMessage: Signal<String>
    
    private var cells = BehaviorRelay<[LOLBracketElement]>(value: [])
    
    init(model: CalendarListModel = CalendarListModel()){
        self.cellData = cells
            .map(model.parseBrancket)
            .asDriver(onErrorDriveWith: .empty())
    }
    
    
}
