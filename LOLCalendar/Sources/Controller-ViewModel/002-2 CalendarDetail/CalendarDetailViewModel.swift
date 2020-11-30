//
//  CalendarDetailViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/12.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import RxOptional

struct OpponentCell {
    let playerLeft: Opponent?
    let playerRight: Opponent?
}
protocol CalendarDetailModelBindable {
    var viewWillAppear: PublishSubject<Void> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    var cellData: Driver<[OpponentCell]> { get }
}

struct DetailHeaderData {
    let scheduleAt: Date
    let leftScore: Int
    let rightScore: Int
    let leftURL: URL
    let rightURL: URL
}

class CalendarDetailViewModel: CommonViewModel, CalendarDetailModelBindable {
    // MARK: - Property
    
    let disposedBag = DisposeBag()
    
    let cellData: Driver<[OpponentCell]>
    let viewWillAppear = PublishSubject<Void>()
    let willDisplayCell = PublishRelay<IndexPath>()
    
    private let cells = BehaviorRelay<[OpponentCell]>(value: [])
    var topData: BehaviorSubject<DetailHeaderData>?
    
    private let activityIndicator = ActivityIndicator()
    
    var isRunning: Observable<Bool> {
        return activityIndicator.asObservable()
    }
    
    // MARK: - Initialize
    
    init(coordinator: SceneCoordinatorType, data: LOLCalendar, model: CalendarDetailModel = CalendarDetailModel()) {
                
        if let leftTeam = data.opponents?.first,
           let rightTeam = data.opponents?.last {
            let leftURL = leftTeam.logoURL ?? URL(string: "")!
            let rightURL = rightTeam.logoURL ?? URL(string: "")!
            let score = data.score ?? [:]
            let scheduleAt = data.scheduleAt ?? Date()
            
            let leftScore = score[leftTeam.id] ?? 0
            let rightScore = score[rightTeam.id] ?? 0

            let header = DetailHeaderData(scheduleAt: scheduleAt, leftScore: leftScore, rightScore: rightScore, leftURL: leftURL, rightURL: rightURL)
            topData = BehaviorSubject<DetailHeaderData>(value: header)
        }
        
        let _ = model.getPlayers(matchID: data.id)
            .toArray()
            .trackActivity(activityIndicator)
            .bind(to: cells)
            .disposed(by: disposedBag)
        
        self.cellData = cells
            .asDriver()
        
        
        super.init(sceneCoordinator: coordinator)
    }
}
