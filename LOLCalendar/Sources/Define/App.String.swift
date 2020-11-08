//
//  App.String.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

extension App {
    enum String {
        static let appName = ""
        
    }
    enum Url {
        static let leagueURL = "https://api.pandascore.co/leagues/293/matches?token=%@&range[begin_at]=2020-01-01T00:00:00Z,2020-12-31T23:59:59Z&page[size]=10&page[number]=1"
        static let brancketURL = "https://api.pandascore.co/tournaments/%d/brackets?token=%@"
    }
    enum Token {
        static let token = ""
    }
}
