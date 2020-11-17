//
//  Rosters.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/15.
//

import Foundation

struct Roster: Hashable {
    static func == (lhs: Roster, rhs: Roster) -> Bool {
        if lhs.acronym == rhs.acronym && lhs.id == rhs.id && lhs.imageURL == rhs.imageURL && lhs.name == rhs.name && lhs.players == rhs.players {
            return true
        } else {
            return false
        }
    }
    
    let id: Int
    let acronym: String
    let name: String
    let imageURL: String
    var players: [Player]
    
    init(id: Int, acronym: String, name: String, imageURL: String, players: [Player] = []) {
        self.id = id
        self.acronym = acronym
        self.name = name
        self.imageURL = imageURL
        self.players = players
    }
    init () {
        self.id = 0
        self.acronym = ""
        self.name = ""
        self.imageURL = ""
        self.players = []
    }
}

struct RosterTop {
    let id: Int
    let acronym: String
    let imageURL: String
}

struct RosterMid {
    let acronym: String
    let name: String
    let imageURL: String
}
