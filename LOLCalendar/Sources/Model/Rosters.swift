//
//  Rosters.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/15.
//

import Foundation

struct Roster: Hashable {
    // MARK: - Property
    
    let id: Int
    let acronym: String
    let name: String
    var imageURL: URL?
    var players: [Player]?
    
    // MARK: - Initialize
    
    init(id: Int, acronym: String, name: String, imageURL: String, players: [Player] = []) {
        self.id = id
        self.acronym = acronym
        self.name = name
        self.imageURL = URL(string: imageURL)
        self.players = players
    }
    init () {
        self.id = 0
        self.acronym = ""
        self.name = ""
        self.imageURL = URL(string: "")
        self.players = []
    }
    
    init (rosterJson json: [String:Any]) {
        self.id = json["id"] as? Int ?? 0
        self.acronym = json["acronym"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        if let url = URL(string: json["image_url"] as? String ?? "") {
            self.imageURL = url
        }
        if let playersJson = json["players"] as? [[String:Any]] {
            self.players = playersJson.map { Player(jsonString: $0) }
        }
    }
    
    // MARK: - Helpers
    
    static func == (lhs: Roster, rhs: Roster) -> Bool {
        if lhs.acronym == rhs.acronym && lhs.id == rhs.id && lhs.imageURL == rhs.imageURL && lhs.name == rhs.name && lhs.players == rhs.players {
            return true
        } else {
            return false
        }
    }
}

struct RosterTop {
    let id: Int
    let acronym: String
    var imageURL: URL?
}

struct RosterMid {
    let acronym: String
    let name: String
    var imageURL: URL?
}
