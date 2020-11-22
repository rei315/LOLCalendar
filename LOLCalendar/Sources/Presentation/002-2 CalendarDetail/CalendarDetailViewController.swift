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
import SnapKit

class CalendarDetailViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: CalendarDetailViewModel!

    @IBOutlet weak var tableView: UITableView!
    
    let indicatorView = UIActivityIndicatorView()
    
    var headerView: DetailHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
}

extension CalendarDetailViewController {
    func bindViewModel() {
        tableView
            .rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
            
        viewModel.isRunning.subscribe(onNext: { loading in
            switch loading {
            case true:
                self.indicatorView.startAnimating()
            case false:
                self.indicatorView.stopAnimating()
            }
        })
        .disposed(by: rx.disposeBag)
        
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: String(describing: CalendarDetailPlayersTableViewCell.self), for: index) as! CalendarDetailPlayersTableViewCell
                cell.setData(players: data)
                cell.isUserInteractionEnabled = false
                return cell
            }
        .disposed(by: rx.disposeBag)
        
        headerView = DetailHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 252))
        tableView.tableHeaderView = headerView
        
        viewModel.topData
            .asObserver()
            .bind(to: headerView.headerData)
            .disposed(by: rx.disposeBag)
    }

    func attribute() {
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.register(UINib(nibName: String(describing: CalendarDetailPlayersTableViewCell.self), bundle: .main), forCellReuseIdentifier: String(describing: CalendarDetailPlayersTableViewCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 143
        tableView.separatorStyle = .none
        
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .blue
        tableView.backgroundView = indicatorView
    }
}

extension CalendarDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143
    }
}
