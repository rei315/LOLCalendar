//
//  LOLCalendar.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation

struct LOLCalendar: Codable, Hashable {
    
    // MARK: - Property
    
    let id: Int
    let identity: String
    var scheduleAt: Date?
    let winnner: Int
    var opponents: [OpponentTeam]?
    var score: [Int:Int]?
    
    // MARK: - Initialize
    
    init(){
        self.id = 0
        self.identity = "\(Date().timeIntervalSinceReferenceDate)"
        self.scheduleAt = Date()
        self.winnner = 0
        self.opponents = []
        self.score = [Int:Int]()
    }
    
    init(calendarJson json: [String:Any]) {
        self.id = json["id"] as? Int ?? 0
        self.identity = "\(Date().timeIntervalSinceReferenceDate)"
        if let dateString = json["scheduled_at"] as? String {
            if let date = stringToDate(dateString: dateString) {
                self.scheduleAt = date
            }
        }
        if let opponentsJson = json["opponents"] as? [[String:Any]] {
            self.opponents = opponentsJson.map { OpponentTeam(opponentTeamJson: $0["opponent"] as! [String : Any]) }
        }
        self.winnner = json["winner_id"] as? Int ?? 0
        
        if let gamesJson = json["games"] as? [[String:Any]] {
            let winnersJson = gamesJson.map { $0["winner"] as? [String:Any]}
            var tmpScore = [Int:Int]()
            winnersJson.forEach { (winnerJson) in
                if let winnerID = winnerJson?["id"] as? Int {
                    if let value = tmpScore[winnerID] {
                        tmpScore.updateValue(value+1, forKey: winnerID)
                    } else {
                        tmpScore.updateValue(1, forKey: winnerID)
                    }
                }
            }
            self.score = tmpScore
        }
    }
    
    // MARK: - Helpers
    
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
}

struct OpponentTeam: Codable, Equatable, Hashable {
    // MARK: - Property
    
    let id: Int
    let name: String
    var logoURL: URL?
    
    // MARK: - Initialize
    
    init(opponentTeamJson json: [String:Any]) {
        self.id = json["id"] as? Int ?? 0
        self.name = json["name"] as? String ?? ""
        if let url = URL(string: json["image_url"] as? String ?? "") {
            self.logoURL = url
        }
    }
}
