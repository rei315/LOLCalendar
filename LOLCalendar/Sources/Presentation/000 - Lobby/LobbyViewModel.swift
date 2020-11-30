//
//  LobbyViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import Foundation
import RxSwift

class LobbyViewModel: CommonViewModel {
    
    // MARK: - Property
    
    struct Input {
        let viewDidTap: AnyObserver<(Void, Int)>
    }
    
    let input: Input
    
    let viewDidTabSubject = PublishSubject<(Void, Int)>()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    
    override init(sceneCoordinator: SceneCoordinatorType){
        input = Input(viewDidTap: viewDidTabSubject.asObserver())

        viewDidTabSubject
            .subscribe(onNext: { data in
                let homeTabViewModel = HomeTabViewModel(sceneCoordinator: sceneCoordinator, leagueType: data.1)
                let homeTabScene = Scene.mainTab(homeTabViewModel)

                sceneCoordinator.transition(to: homeTabScene, using: .push, animated: true)
            })
            .disposed(by: disposeBag)
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
