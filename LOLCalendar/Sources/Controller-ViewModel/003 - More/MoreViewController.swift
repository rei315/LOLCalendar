//
//  MoreViewController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/17.
//

import UIKit
import SnapKit

class MoreViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - Property
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: MoreViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }

}

extension MoreViewController {
    // MARK: - Helpers
    
    func bindViewModel() {
        
    }
    
    func attribute() {
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
