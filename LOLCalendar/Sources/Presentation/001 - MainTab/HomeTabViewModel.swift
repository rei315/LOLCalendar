//
//  HomeTabViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import Foundation

class HomeTabViewModel: CommonViewModel {
    
    let calendarListViewModel: CalendarListViewModel
//    let rosterViewModel: RosterViewModel
    let moreViewModel: MoreViewModel

    
    init(sceneCoordinator: SceneCoordinatorType, leagueType: Int) {
        self.calendarListViewModel = CalendarListViewModel(coordinator: sceneCoordinator, leagueType: leagueType)
//        self.rosterViewModel = RosterViewModel(leagueType: leagueType, sceneCoordinator: sceneCoordinator)
        self.moreViewModel = MoreViewModel(sceneCoordinator: sceneCoordinator)
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
