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
import Kingfisher

class CalendarDetailViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: CalendarDetailViewModel!
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var scoreDivideLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let indicatorView = UIActivityIndicatorView()
    
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
        
        viewModel.scheduleAt
            .bind(to: timeLabel.rx.text)
            .disposed(by: rx.disposeBag)

        viewModel.leftScore
            .map { String(describing: $0) }
            .bind(to: leftScoreLabel.rx.text)
            .disposed(by: rx.disposeBag)
        viewModel.rightScore
            .map { String(describing: $0) }
            .bind(to: rightScoreLabel.rx.text)
            .disposed(by: rx.disposeBag)
            
        viewModel.leftURL
            .map { URL(string: $0) }
            .bind(to: leftImageView.kf.rx.image(options: [.transition(.fade(0.2)),
                                                          .keepCurrentImageWhileLoading,
                                                          .forceTransition]))
            .disposed(by: rx.disposeBag)
        
        viewModel.rightURL
            .map { URL(string: $0) }
            .bind(to: rightImageView.kf.rx.image(options: [.transition(.fade(0.2)),
                                                          .keepCurrentImageWhileLoading,
                                                          .forceTransition]))
            .disposed(by: rx.disposeBag)
        
    }

    func attribute() {
        
        tableView.register(UINib(nibName: String(describing: CalendarDetailPlayersTableViewCell.self), bundle: .main), forCellReuseIdentifier: String(describing: CalendarDetailPlayersTableViewCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 143
        tableView.separatorStyle = .none
        
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .blue
        tableView.backgroundView = indicatorView
        
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        rightScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        vsLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreDivideLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension CalendarDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143
    }
}
