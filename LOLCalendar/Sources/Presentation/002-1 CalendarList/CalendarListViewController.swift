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
            .drive(tableView.rx.items) { [self] tv, row, data in
                if (data.opponents.isEmpty) {
                    self.showAlert(title: "서버 오류", message: "서버에 연결하지 못하였습니다.", style: .alert, actions: [AlertAction.action(title: "확인")])
                        .subscribe(onNext: { index in
                            print(index)
                        })
                        .disposed(by: rx.disposeBag)
                    return UITableViewCell()
                }
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: String(describing: CalendarListTableViewCell.self), for: index) as! CalendarListTableViewCell
                cell.setData(data: data)
                return cell
            }
            .disposed(by: rx.disposeBag)
            
        Observable.zip(tableView.rx.modelSelected(CalendarListTableViewCell.Data.self), tableView.rx.itemSelected)
            .do(onNext: { [unowned self] (_, indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .map { $0.0 }
            .bind(to: viewModel.detailAction.inputs)
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
    
    func showAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction]) -> Observable<Int>
    {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(index)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }

            self.present(alertController, animated: true, completion: nil)

            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}
