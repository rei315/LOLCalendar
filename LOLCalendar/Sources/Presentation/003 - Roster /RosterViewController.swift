//
//  RosterViewController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx
import Kingfisher

class RosterViewControler: UIViewController, ViewModelBindableType {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: RosterViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
}

extension RosterViewControler {
    
    func bindViewModel() {
        viewModel.topCellData
            .drive(collectionView.rx.items) { (cv, row, data) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = cv.dequeueReusableCell(withReuseIdentifier: String(describing: RosterTopCell.self), for: indexPath) as! RosterTopCell
                cell.setData(data: data)
                cell.imageView.rx.tapGesture().subscribe(onNext: {_ in
                    self.viewModel.switchSelectedTeam(id: cell.id)
                })
                .disposed(by: cell.disposeBag)
                    
                return cell
            }
            .disposed(by: rx.disposeBag)
    }
    
    func attribute() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: String(describing: RosterTopCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: RosterTopCell.self))
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
}

extension RosterViewControler: UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2.5)
    }
}
