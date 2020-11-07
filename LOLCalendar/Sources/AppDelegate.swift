//
//  AppDelegate.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let coordinator = SceneCoordinator(window: window!)
        let lobbyViewModel = LobbyViewModel(sceneCoordinator: coordinator)
        let lobbyScene = Scene.lobby(lobbyViewModel)
        
        coordinator.transition(to: lobbyScene, using: .root, animated: false)
        
        return true
    }


}

