//
//  Scene.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import UIKit

enum Scene {
    case lobby(LobbyViewModel)
    case mainTab(HomeTabViewModel)
    case calendarList(CalendarListViewModel)
    case calendarDetail(CalendarDetailViewModel)
    case roster(RosterViewModel)
    case more(MoreViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        switch self{
        case .lobby(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "LobbyNav") as? UINavigationController else {
            fatalError()
        }
            guard var lobbyVC = nav.viewControllers.first as? LobbyViewController else {
            fatalError()
        }
            lobbyVC.bind(viewModel: viewModel)
            return nav
            
        case .mainTab(let viewModel):
            guard var homeTabViewController = storyboard.instantiateViewController(withIdentifier: "HomeTab") as? HomeTabViewController else {
                fatalError()
            }
            homeTabViewController.bind(viewModel: viewModel)
            
            return homeTabViewController
            
        case .calendarList(let viewModel):
            guard var calendarListViewController = storyboard.instantiateViewController(identifier: "CalendarList") as? CalendarListViewController else {
                fatalError()
            }
            calendarListViewController.bind(viewModel: viewModel)
            return calendarListViewController
            
        case .calendarDetail(let viewModel):
            guard var calendarDetailViewController = storyboard.instantiateViewController(withIdentifier: "CalendarDetail") as? CalendarDetailViewController else {
                fatalError()
            }
            calendarDetailViewController.bind(viewModel: viewModel)
            return calendarDetailViewController
            
        case .more(let viewModel):
            guard var moreVC = storyboard.instantiateViewController(withIdentifier: "More") as? MoreViewController else {
                fatalError()
            }
            moreVC.bind(viewModel: viewModel)
            return moreVC
        case .roster(let viewModel):
            guard var rosterViewController = storyboard.instantiateViewController(withIdentifier: "Roster") as? RosterViewControler else {
                fatalError()
            }
            rosterViewController.bind(viewModel: viewModel)
            return rosterViewController
        }
    }
}
