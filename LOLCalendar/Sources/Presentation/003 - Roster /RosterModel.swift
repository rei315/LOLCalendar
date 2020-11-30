//
//  RosterModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/15.
//

import Foundation
import RxSwift

struct RosterModel {
    // MARK: - API
    
    func getTournamentID(leagueID: Int) -> Observable<Int> {
        
        var tmpLeague = 0
        switch leagueID {
        case 0:
            tmpLeague = League.LCK.rawValue
        case 1:
            tmpLeague = League.LPL.rawValue
        case 2:
            tmpLeague = League.LEC.rawValue
        default:
            break
        }
        
        return APIService.fetchLOLLeagueTournamentIDRecent(url: URL(string: String(format: App.Url.recentTournamentIDURL, tmpLeague, App.Token.token))!)
    }
    
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
    
    func getRosters(tournamentID: Int) -> Observable<Roster> {
        return APIService.fetchLOLRosters(url: URL(string: String(format: App.Url.rostersURL, tournamentID, App.Token.token))!)
    }
    
    func getTeam(teamID: Int) -> Observable<Player> {
        return APIService.fetchLOLTeam(url: URL(string: String(format: App.Url.teamsURL, teamID))!)
    }
    func parseTopCell(value: [RosterTop]) -> [RosterTopCell.Data] {
        return value.map {
            (id: $0.id, acronym: $0.acronym, imageURL: $0.imageURL!)
        }
    }
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
