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
        print("---------------------------------------------------")
        print(value.count)
        print("---------------------------------------------------")
        return value.map {
            (id: $0.id , scheduledAt: $0.scheduledAt , status: $0.status , winnerTeam: "\($0.winnerID)" , firstLogoUrl: $0.opponents.first?.opponent.imageURL ?? "", secondLogoUrl: $0.opponents.last?.opponent.imageURL ?? "")
        }
    }
    
    func getLOLEsport() -> Observable<LOLESport> {
        return APIService.fetchLOLESport(url: URL(string: String(format: App.Url.leagueURL, App.Token.token))!)
    }
    func getBrancket(id: Int) -> Observable<LOLBracketElement> {        
        return APIService.fetchBracket(url: URL(string: String(format: App.Url.brancketURL, id, App.Token.token))!)
    }

}
