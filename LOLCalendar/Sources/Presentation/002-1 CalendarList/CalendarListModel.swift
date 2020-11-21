//
//  CalendarListModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation
import RxSwift

struct CalendarListModel {
    
    //world champion 297
    
    func getLOLLeagueTournamentId(league: Int, page: Int = 1) -> Observable<(Int, Bool, Int)> {
        var tmpLeague = 0
        switch league {
        case 0:
            tmpLeague = League.LCK.rawValue
        case 1:
            tmpLeague = League.LPL.rawValue
        case 2:
            tmpLeague = League.LEC.rawValue
        default:
            break
        }
        
        return APIService.fetchLOLLeagueTournamentID(url: URL(string: String(format: App.Url.leagueURL, tmpLeague,App.Token.token, page))!)
    }
    
    func getLOLBracket(id: Int) -> Observable<LOLCalendar> {
        let isError = id == -1 ? true : false
        return APIService.fetchLOLBracket(url: URL(string: String(format: App.Url.brancketURL, id, App.Token.token))!, isError: isError)
    }
    
//    func parseBracket(value: [LOLCalendar]) -> [CalendarListTableViewCell.Data] {
//        return value.map {
//            (id: $0.id, scheduleAt: $0.scheduleAt, winner: $0.winnner, opponents: $0.opponents, score: $0.score)
//        }
//    }
    
    func fetchMoreData(league: Int, page: Int) -> Observable<(Int, Bool, Int)>{
        var tmpLeague = 0
        switch league {
        case 0:
            tmpLeague = League.LCK.rawValue
        case 1:
            tmpLeague = League.LPL.rawValue
        case 2:
            tmpLeague = League.LEC.rawValue
        default:
            break
        }
        
        return APIService.fetchLOLLeagueTournamentID(url: URL(string: String(format: App.Url.leagueURL, tmpLeague, App.Token.token, page))!)
    }
}
