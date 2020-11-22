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
import SnapKit
import RxSwiftExt

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
        tableView
            .rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
        
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
        
        viewModel.cells
            .map( { (items) -> [LOLCalendar] in
                return items.sorted { (bracket1, bracket2) -> Bool in
                    return bracket1.scheduleAt > bracket2.scheduleAt
                }
            })
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
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let cellNib = UINib(nibName: String(describing: CalendarListTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: String(describing: CalendarListTableViewCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 112
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width/7))
        let moreButton = LCAnimatedButton(title: "더보기", backgroundColor: .lightGray)
        moreButton.rx.tap
            .subscribe({ _ in
                self.onUpdateList()
            })
            .disposed(by: rx.disposeBag)
        moreButton.setTitleColor(.white, for: .normal)
        footerView.addSubview(moreButton)
        
        moreButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalToSuperview().dividedBy(2)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        tableView.tableFooterView = footerView
        
    }
    
    private func onUpdateList() {
        if !viewModel.updateList() {
            self.showAlert(title: "로딩 실패", message: "마지막 페이지 입니다.", style: .alert, actions: [AlertAction.action(title: "확인")])
                .subscribe(onNext: { index in
                    print(index)
                })
                .disposed(by: rx.disposeBag)                
        }
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

extension CalendarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}
