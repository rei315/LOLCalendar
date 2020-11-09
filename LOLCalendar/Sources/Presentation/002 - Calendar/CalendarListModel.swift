//
//  CalendarListModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation
import RxSwift

struct CalendarListModel {

    func getLOLLeagueTournamentId(page: Int = 1) -> Observable<(Int, Bool, Int)> {
        return APIService.fetchLOLLeagueTournamentID(url: URL(string: String(format: App.Url.leagueURL, App.Token.token, page))!)
    }
    func getLOLBracket(id: Int) -> Observable<LOLCalendar> {
        return APIService.fetchLOLBracket(url: URL(string: String(format: App.Url.brancketURL, id, App.Token.token))!)
    }
    func parseBracket(value: [LOLCalendar]) -> [CalendarListTableViewCell.Data] {
        return value.map {
            (scheduleAt: $0.scheduleAt, winner: $0.winnner, opponents: $0.opponents, score: $0.score)
        }
    }
    func fetchMoreData(page: Int) -> Observable<(Int, Bool, Int)>{
        return APIService.fetchLOLLeagueTournamentID(url: URL(string: String(format: App.Url.leagueURL, App.Token.token, page))!)
    }
}
