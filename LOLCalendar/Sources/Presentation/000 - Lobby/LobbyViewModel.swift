//
//  LobbyViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import Foundation
import RxSwift

class LobbyViewModel: CommonViewModel {
    
    struct Input {
        let viewDidTap: AnyObserver<Void>
    }
    
    let input: Input
    
    let viewDidTabSubject = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    
    override init(sceneCoordinator: SceneCoordinatorType){
        input = Input(viewDidTap: viewDidTabSubject.asObserver())
        
        viewDidTabSubject
            .subscribe(onNext: {
                let homeTabViewModel = HomeTabViewModel(sceneCoordinator: sceneCoordinator)
                let homeTabScene = Scene.mainTab(homeTabViewModel)

                sceneCoordinator.transition(to: homeTabScene, using: .root, animated: false)
            })
            .disposed(by: disposeBag)
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
