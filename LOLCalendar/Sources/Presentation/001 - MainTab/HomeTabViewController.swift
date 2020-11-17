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
        case More
    }
    
    var calendarListViewController: CalendarListViewController?
//    var rosterViewController: RosterViewControler?
    var moreViewController: MoreViewController?
    
    let tabBarItems: [Tab:UITabBarItem] = [
        .CalendarList: UITabBarItem(title: "최근 경기", image: UIImage(systemName: "sportscourt.fill"), tag: 0),
        .More: UITabBarItem(title: "더보기", image: UIImage(systemName: "ellipsis.circle.fill"), tag: 1)
        
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
        
//        rosterViewController = Scene.roster(viewModel.rosterViewModel).instantiate() as? RosterViewControler
        
        moreViewController = Scene.more(viewModel.moreViewModel).instantiate() as? MoreViewController
        
        calendarListViewController?.tabBarItem = tabBarItems[.CalendarList]
//        rosterViewController?.tabBarItem = tabBarItems[.Setting]
        moreViewController?.tabBarItem = tabBarItems[.More]
        
        self.viewControllers = [
            calendarListViewController! as UIViewController,
//            rosterViewController! as UIViewController
            moreViewController! as UIViewController
        ]
    }
}
