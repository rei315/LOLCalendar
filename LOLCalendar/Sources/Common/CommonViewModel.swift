//
//  CommonViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType){
        self.sceneCoordinator = sceneCoordinator
    }
}
