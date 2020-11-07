//
//  LobbyController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import NSObject_Rx

class LobbyViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: LobbyViewModel!
    let tapGesture = UITapGestureRecognizer()
    
}

extension LobbyViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        
        tapGesture.rx.event.asObservable()
            .map { _ in Void() }
            .subscribe(viewModel.input.viewDidTap)
            .disposed(by: rx.disposeBag)
        
        view.addGestureRecognizer(tapGesture)
    }
}
