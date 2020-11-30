//
//  CalendarListTableViewCell.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class CalendarListTableViewCell: UITableViewCell {

    // MARK: - Property
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var leftResultLabel: UILabel!
    @IBOutlet weak var leftTeamImage: UIImageView!
    
    @IBOutlet weak var rightResultLabel: UILabel!
    @IBOutlet weak var rightTeamImage: UIImageView!
    
    @IBOutlet weak var vsLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    enum Result: String {
        case Win = "승"
        case Defeat = "패"
    }
    
    // MARK: - Initialize
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Helpers
    
    func setData(data: LOLCalendar) {
        
        dateLabel.text = dateToString(date: data.scheduleAt!)
        leftResultLabel.text = ""
        let left = data.opponents?.first
        let right = data.opponents?.last
        
        // Result
        leftResultLabel.text = Result.Defeat.rawValue
        rightResultLabel.text = Result.Defeat.rawValue
        leftResultLabel.textColor = .red
        rightResultLabel.textColor = .red
        if (data.winnner == left?.id){
            leftResultLabel.text = Result.Win.rawValue
            leftResultLabel.textColor = .blue
        } else {
            rightResultLabel.text = Result.Win.rawValue
            rightResultLabel.textColor = .blue
        }
        
        // Logo Image
        leftTeamImage.translatesAutoresizingMaskIntoConstraints = false
        rightTeamImage.translatesAutoresizingMaskIntoConstraints = false
        
        leftTeamImage.kf.setImage(with: left!.logoURL)

        rightTeamImage.kf.setImage(with: right!.logoURL)
    }
            
    func attribute() {
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(108)
            make.trailing.equalToSuperview().offset(-108)
            make.centerX.equalTo(vsLabel.snp.centerX)
        }
        leftTeamImage.snp.makeConstraints { (make) in
            make.width.equalTo(leftTeamImage.snp.height).multipliedBy(1.0/1.0)
            make.height.equalTo(40)
            make.centerY.equalTo(vsLabel.snp.centerY)
            make.leading.equalToSuperview().offset(34)
        }
        rightTeamImage.snp.makeConstraints { (make) in
            make.width.equalTo(rightTeamImage.snp.height).multipliedBy(1.0/1.0)
            make.height.equalTo(40)
            make.centerY.equalTo(vsLabel.snp.centerY)
            make.centerY.equalTo(rightResultLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-34)
        }
        vsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        leftResultLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(vsLabel.snp.centerY)
            make.leading.equalTo(leftTeamImage.snp.trailing).offset(30)
            make.trailing.equalTo(vsLabel.snp.leading).offset(-30)
        }
        rightResultLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(vsLabel.snp.centerY)
            make.leading.equalTo(vsLabel.snp.trailing).offset(30)
            make.trailing.equalTo(rightTeamImage.snp.leading).offset(-30)
        }
    }
}
