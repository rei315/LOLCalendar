//
//  CalendarListModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation
import RxSwift

struct CalendarListModel {
    func parseBrancket(value: [LOLBracketElement]) -> [CalendarListTableViewCell.Data] {
        return value.map {
            (id: $0.id ?? 0, scheduledAt: $0.scheduledAt ?? Date(), status: $0.status ?? Status.notPlayed, winnerTeam: "\($0.winnerID)" ?? "", firstLogoUrl: $0.opponents.first?.opponent.imageURL ?? "", secondLogoUrl: $0.opponents.last?.opponent.imageURL ?? "")
        }
    }
    
    func getLOLEsport() -> Observable<LOLESport> {
        return APIService.fetchLOLESport(url: URL(string: String(format: App.Url.leagueURL, App.Token.token))!)
    }
    func getBrancket(id: Int, url: URL) -> Observable<LOLBracketElement> {        
        return APIService.fetchBracket(url: URL(string: String(format: App.Url.brancketURL, id, App.Token.token))!)
    }
}
