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

struct LOLCalendar: Codable, Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(scheduleAt)
    }
    
    static func == (lhs: LOLCalendar, rhs: LOLCalendar) -> Bool {
        if lhs.id == rhs.id && lhs.identity == rhs.identity &&
            lhs.opponents == rhs.opponents &&
            lhs.scheduleAt == rhs.scheduleAt &&
            lhs.score == rhs.score &&
            lhs.winnner == rhs.winnner {
            return true
        } else {
            return false
        }
    }
    var id: Int
    var identity: String
    var scheduleAt: Date
    var winnner: Int
    var opponents: [OpponentTeam]
    var score: [Int:Int]
    
    init(){
        self.id = 0
        self.identity = "\(Date().timeIntervalSinceReferenceDate)"
        self.scheduleAt = Date()
        self.winnner = 0
        self.opponents = []
        self.score = [Int:Int]()
    }
}

struct OpponentTeam: Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let logoURL: String
}
