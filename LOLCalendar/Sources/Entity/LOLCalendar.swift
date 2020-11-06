//
//  LOLCalendar.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation

struct LOLCalendar: Codable {
    let id: Int
    let scheduledAt: Date
    let status: Status
    let winnerID: Int
    let opponents: [OpponentElement]
}
