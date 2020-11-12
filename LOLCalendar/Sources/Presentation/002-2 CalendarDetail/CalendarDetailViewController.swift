//
//  CalendarDetailViewController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/12.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

class CalendarDetailViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: CalendarDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CalendarDetailViewController {
    func bindViewModel() {
        
    }
}
