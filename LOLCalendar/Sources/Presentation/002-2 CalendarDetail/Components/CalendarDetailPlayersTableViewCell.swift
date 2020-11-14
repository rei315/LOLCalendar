//
//  CalendarDetailPlayersTableViewCell.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/14.
//

import UIKit
import Kingfisher

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

        // Configure the view for the selected state
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
        leftRoleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftNameLabel.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        
        rightRoleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightNameLabel.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
    }
}
