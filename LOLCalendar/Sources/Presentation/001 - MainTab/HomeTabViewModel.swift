//
//  HomeTabViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import Foundation

class HomeTabViewModel: CommonViewModel {
    
    let calendarListViewModel: CalendarListViewModel
    let settingViewModel: SettingViewModel
    
    override init(sceneCoordinator: SceneCoordinatorType) {
        self.calendarListViewModel = CalendarListViewModel(coordinator: sceneCoordinator)
        self.settingViewModel = SettingViewModel(sceneCoordinator: sceneCoordinator)
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
