//
//  SettingViewController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import UIKit

class SettingViewControler: UIViewController, ViewModelBindableType {
    
    var viewModel: SettingViewModel!
    
}

extension SettingViewControler {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func bindViewModel() {
        
    }
}

