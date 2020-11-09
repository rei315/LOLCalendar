//
//  LOLCalendar.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation

//struct LOLCalendar: Codable {
//    let id: Int
//    let scheduledAt: Date
//    let status: Status
//    let winnerID: Int
//    let opponents: [OpponentElement]
//}

struct LOLCalendar: Codable {
    var scheduleAt: Date
    var winnner: Int
    var opponents: [OpponentTeam]
    var score: [Int:Int]
    
    init(){
        self.scheduleAt = Date()
        self.winnner = 0
        self.opponents = []
        self.score = [Int:Int]()
    }
}

struct OpponentTeam: Codable {
    let id: Int
    let name: String
    let logoURL: String
}
