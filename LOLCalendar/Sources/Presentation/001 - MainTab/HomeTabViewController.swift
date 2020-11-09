//
//  HomeTabViewController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import UIKit

class HomeTabViewController: UITabBarController, ViewModelBindableType {
    
    enum Tab: Int {
        case CalendarList
        case Setting
    }
    
    var calendarListViewController: CalendarListViewController?
    var settingViewController: SettingViewControler?
    
    let tabBarItems: [Tab:UITabBarItem] = [
        .CalendarList: UITabBarItem(tabBarSystemItem: .recents, tag: 0),
        .Setting: UITabBarItem(tabBarSystemItem: .more, tag: 1)
    ]
    
    var viewModel: HomeTabViewModel!    
}

extension HomeTabViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
    
    func bindViewModel() {
                
    }
    
    func attribute() {
        calendarListViewController = Scene.calendarList(viewModel.calendarListViewModel).instantiate() as? CalendarListViewController
        
        settingViewController = Scene.setting(viewModel.settingViewModel).instantiate() as? SettingViewControler
        
        calendarListViewController?.tabBarItem = tabBarItems[.CalendarList]
        settingViewController?.tabBarItem = tabBarItems[.Setting]
        
        self.viewControllers = [
            UINavigationController(rootViewController: calendarListViewController!),
            UINavigationController(rootViewController: settingViewController!)
        ]
    }
}
