//
//  CalendarDetailModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/12.
//

import Foundation
import RxSwift

struct CalendarDetailModel {

    func getPlayers(matchID: Int) -> Observable<OpponentCell> {
        return APIService.fetchLOLOpponent(url: URL(string: String(format: App.Url.opponentsURL, matchID, App.Token.token))!)
    }
}
