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
    var scheduleAt: String = ""
    var leftScore: Int = 0
    var rightScore: Int = 0
    var leftURL: String = ""
    var rightURL: String = ""
}

class CalendarDetailViewModel: CommonViewModel, CalendarDetailModelBindable {
    
    let disposedBag = DisposeBag()
    
    let cellData: Driver<[OpponentCell]>
    let viewWillAppear = PublishSubject<Void>()
    let willDisplayCell = PublishRelay<IndexPath>()
    
    private let cells = BehaviorRelay<[OpponentCell]>(value: [])
    var topData: BehaviorSubject<DetailHeaderData>
    
    private let activityIndicator = ActivityIndicator()
    
    var isRunning: Observable<Bool> {
        return activityIndicator.asObservable()
    }
    
    init(coordinator: SceneCoordinatorType, data: LOLCalendar, model: CalendarDetailModel = CalendarDetailModel()) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.string(from: data.scheduleAt)
                
        let leftTeam = data.opponents.first
        let rightTeam = data.opponents.last
         
        let leftURL = leftTeam?.logoURL ?? ""
        let rightURL = rightTeam?.logoURL ?? ""
        let leftScore = data.score[leftTeam!.id] ?? 0
        let rightScore = data.score[rightTeam!.id] ?? 0
        let header = DetailHeaderData(scheduleAt: date, leftScore: leftScore, rightScore: rightScore, leftURL: leftURL, rightURL: rightURL)
        topData = BehaviorSubject<DetailHeaderData>(value: header)
        
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
