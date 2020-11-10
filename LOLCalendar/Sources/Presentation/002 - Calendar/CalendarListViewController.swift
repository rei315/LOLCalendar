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
    
    let indicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
}

extension CalendarListViewController {
    func bindViewModel() {
        viewModel.isRunning.subscribe(onNext: { loading in
            switch loading {
            case true:
                self.indicatorView.startAnimating()
            case false:
                self.indicatorView.stopAnimating()
            }
        })
        .disposed(by: rx.disposeBag)
        
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
            
    }
    
    func attribute() {
        let cellNib = UINib(nibName: String(describing: CalendarListTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: String(describing: CalendarListTableViewCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 112
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .blue
        tableView.backgroundView = indicatorView
    }
}
