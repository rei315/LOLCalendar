//
//  CalendarDetailPlayersTableViewCell.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/14.
//

import UIKit
import Kingfisher
import SnapKit

class CalendarDetailPlayersTableViewCell: UITableViewCell {


    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftRoleLabel: UILabel!
    @IBOutlet weak var leftNameLabel: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightRoleLabel: UILabel!
    @IBOutlet weak var rightNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(players: OpponentCell) {
        if let left = players.playerLeft {
            leftRoleLabel.text = left.role
            leftNameLabel.text = left.name
            leftImageView.kf.setImage(with: URL(string: left.image_url))
        } else {
            leftRoleLabel.text = ""
            leftNameLabel.text = ""
            leftImageView.image = nil
        }
        
        if let right = players.playerRight {
            rightRoleLabel.text = right.role
            rightNameLabel.text = right.name
            rightImageView.kf.setImage(with: URL(string: right.image_url))
        } else {
            rightRoleLabel.text = ""
            rightNameLabel.text = ""
            rightImageView.image = nil
        }
    }
    
    func attribute() {
        leftImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(leftRoleLabel.snp.leading).offset(-15)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        rightImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(rightRoleLabel.snp.trailing).offset(15)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        leftRoleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftImageView.snp.centerY)
        }
        rightRoleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(rightImageView.snp.centerY)
        }
        leftNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftImageView.snp.centerX)
            make.top.equalTo(leftImageView.snp.bottom).offset(15)
        }
        rightNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(rightImageView.snp.centerX)
            make.top.equalTo(rightImageView.snp.bottom).offset(15)
        }
    }
}
