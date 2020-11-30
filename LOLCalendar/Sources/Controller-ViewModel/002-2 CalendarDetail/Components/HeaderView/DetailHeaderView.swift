//
//  DetailHeaderView.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

class DetailHeaderView: XibView {

    // MARK: - Property
    
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var scoreDivideLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var lefetScoreLabel: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    var headerData =  BehaviorSubject<DetailHeaderData?>(value: nil)
    
    let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindData()
        attribute()
    }
    
    // MARK: - Helpers
    
    func bindData(){
        headerData
            .filterNil()
            .map { dateToString(date: $0.scheduleAt) }
            .asObservable()
            .bind(to: timeLabel.rx.text)
            .disposed(by: disposeBag)
        
        headerData
            .filterNil()
            .map { $0.leftURL }
            .asObservable()
            .bind(to: leftImageView.kf.rx.image(options: [.transition(.fade(0.2)),
                                                          .keepCurrentImageWhileLoading,
                                                          .forceTransition]))
            .disposed(by: disposeBag)

        headerData
            .filterNil()
            .map { $0.rightURL }
            .asObservable()
            .bind(to: rightImageView.kf.rx.image(options: [.transition(.fade(0.2)),
                                                          .keepCurrentImageWhileLoading,
                                                          .forceTransition]))
            .disposed(by: disposeBag)
        
        headerData
            .filterNil()
            .map { String($0.leftScore) }
            .asObservable()
            .bind(to: lefetScoreLabel.rx.text)
            .disposed(by: disposeBag)
        
        headerData
            .filterNil()
            .map { String($0.rightScore) }
            .asObservable()
            .bind(to: rightScoreLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindData()
        attribute()
    }
    
    func attribute() {
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        vsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        scoreDivideLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(vsLabel.snp.bottom).offset(50)
        }
        lefetScoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(scoreDivideLabel.snp.centerY)
            make.leading.equalTo(leftImageView.snp.trailing)
        }
        rightScoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(scoreDivideLabel.snp.centerY)
            make.trailing.equalTo(rightImageView.snp.leading)
        }
        leftImageView.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.top.equalToSuperview().offset(84)
            make.leading.equalToSuperview().offset(42)
        }
        rightImageView.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.top.equalToSuperview().offset(84)
            make.trailing.equalToSuperview().offset(-42)
        }
    }
}
