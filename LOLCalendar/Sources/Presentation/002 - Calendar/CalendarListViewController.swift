//
//  CalendarListViewController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import UIKit
import RxSwift
import RxCocoa
import RxAppState
import NSObject_Rx

class CalendarListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: CalendarListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
}

extension CalendarListViewController {
    func bindViewModel() {
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: rx.disposeBag)
        
        tableView.rx.willDisplayCell
            .map { $0.indexPath }
            .bind(to: viewModel.willDisplayCell)
            .disposed(by: rx.disposeBag)
        
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in                
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: String(describing: CalendarListTableViewCell.self), for: index) as! CalendarListTableViewCell
                cell.setData(data: data)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        viewModel.cellData
            .asObservable()
            .subscribe(onNext: { tmp in
                print("hihihi")
            })
            
    }
    
    func attribute() {
        let cellNib = UINib(nibName: String(describing: CalendarListTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: String(describing: CalendarListTableViewCell.self))
    }
}
