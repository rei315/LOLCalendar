//
//  CalendarListTableViewCell.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import UIKit

class CalendarListTableViewCell: UITableViewCell {

    typealias Data = (id: Int, scheduledAt: Date, status: Status, winnerTeam: String, firstLogoUrl: String, secondLogoUrl: String)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
