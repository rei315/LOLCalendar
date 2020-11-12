//
//  CalendarDetailModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/12.
//

import Foundation
import RxSwift

struct CalendarDetailModel {
    func getTeamPlayers(teamID: Int) -> Observable<Player> {
        return APIService.fetchLOLTeam(url: URL(string: String(format: App.Url.teamsURL, teamID, App.Token.token))!)
    }
}
