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

class CalendarDetailViewModel: CommonViewModel, CalendarDetailModelBindable {
    typealias Data = (id: Int, scheduleAt: Date, winnner: Int, opponents: [OpponentTeam], score: [Int:Int])
    
    let disposedBag = DisposeBag()
    
    var matchData: Data
    
    var scheduleAt: BehaviorSubject<String>
    var leftScore: BehaviorSubject<Int>
    var rightScore: BehaviorSubject<Int>
    
    var leftURL: BehaviorSubject<String>
    var rightURL: BehaviorSubject<String>
    let cellData: Driver<[OpponentCell]>
    let viewWillAppear = PublishSubject<Void>()
    let willDisplayCell = PublishRelay<IndexPath>()
    
    private let cells = BehaviorRelay<[OpponentCell]>(value: [])
    
    private let activityIndicator = ActivityIndicator()
    
    var isRunning: Observable<Bool> {
        return activityIndicator.asObservable()
    }
    
    init(coordinator: SceneCoordinatorType, data: Data, model: CalendarDetailModel = CalendarDetailModel()) {
        self.matchData = data
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.string(from: data.scheduleAt)
        self.scheduleAt = BehaviorSubject<String>(value: date)
                
        let leftTeam = data.opponents.first
        self.leftScore = BehaviorSubject<Int>(value: data.score[leftTeam!.id] ?? 0)
        self.leftURL = BehaviorSubject<String>(value: leftTeam!.logoURL)
        
        let rightTeam = data.opponents.last
        self.rightScore = BehaviorSubject<Int>(value: data.score[rightTeam!.id] ?? 0)
        self.rightURL = BehaviorSubject<String>(value: rightTeam!.logoURL)
        
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
