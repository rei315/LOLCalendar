//
//  CalendarDetailViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/12.
//

import Foundation
import RxSwift
import RxCocoa
import Action


class CalendarDetailViewModel: CommonViewModel {
    typealias Data = (scheduleAt: Date, winnner: Int, opponents: [OpponentTeam], score: [Int:Int])
    
    let disposedBag = DisposeBag()
    
    var data: Data
    
    init(coordinator: SceneCoordinatorType, data: Data, model: CalendarDetailModel = CalendarDetailModel()) {
        self.data = data
        
        let leftTeam = model.getTeamPlayers(teamID: data.opponents.first?.id ?? -1)
        
        let rightTeam = model.getTeamPlayers(teamID: data.opponents.last?.id ?? -1)
        
        super.init(sceneCoordinator: coordinator)
    }
}
