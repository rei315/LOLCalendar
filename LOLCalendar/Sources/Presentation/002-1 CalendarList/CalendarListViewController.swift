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
import Action

class CalendarListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: CalendarListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    static let startLoadingOffset: CGFloat = 20.0

    static func isNearTheBottomEdge(contentOffset: CGPoint, _ tableView: UITableView) -> Bool {
        return contentOffset.y + tableView.frame.size.height + startLoadingOffset > tableView.contentSize.height
    }
    
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
                IndicatorView.shared.show()
            case false:
                IndicatorView.shared.hide()
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
        
        let _ = tableView.rx.contentOffset
            .flatMap { offset in
                CalendarListViewController.isNearTheBottomEdge(contentOffset: offset, self.tableView)
                    ? Observable.just(())
                    : Observable.empty()
            }
            .subscribe({ _ in
                print("hi")
//                self.onUpdateList()
            })
            .disposed(by: rx.disposeBag)
        
            
        
        viewModel.cells
            .bind(to: tableView.rx.items) { [unowned self] tv, row, data in
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
            
        Observable.zip(tableView.rx.modelSelected(LOLCalendar.self), tableView.rx.itemSelected)
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
        
//        let footerView = UIView()
//        tableView.tableFooterView = footerView
//        footerView.snp.makeConstraints { (make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(100)
//
//        }
//        footerView.backgroundColor = .brown
//        let moreButton = UIButton()
//        moreButton.rx.tap
//            .subscribe({ _ in
//                self.onUpdateList()
//            })
//            .disposed(by: rx.disposeBag)
//
//        footerView.addSubview(moreButton)
//        moreButton.snp.makeConstraints { (make) in
//            make.width.equalToSuperview()
//            make.height.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
    }
    
    private func onUpdateList() {
        IndicatorView.shared.show()
        viewModel.updateList()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onCompleted: {
                    IndicatorView.shared.hide()
                    print("complete")
            })
            .disposed(by: rx.disposeBag)
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
