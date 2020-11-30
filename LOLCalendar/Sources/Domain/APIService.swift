//
//  APIService.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation
import RxSwift
import RxCocoa

class APIService {
    // MARK: - API
    
    // MARK: - Rosters
    static func fetchLOLRosters(url: URL) -> Observable<Roster> {
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    if let response = response as? HTTPURLResponse {
                        let tmpError = NSError(domain: "", code: response.statusCode, userInfo: nil)
                        observer.onError(tmpError)
                    }
                    observer.onError(NSError(domain: "", code: 0, userInfo: nil))
                }
                
                do {
                    if let data = data {
                        let jsonObjet = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        if let jsonDic = jsonObjet as? [String:Any] {
                            if let rosters = jsonDic["rosters"] as? [[String:Any]] {
                                for rosterJson in rosters {
                                    let tmpRoster: Roster = Roster(rosterJson: rosterJson)

                                    observer.onNext(tmpRoster)           
                                }
                                observer.onCompleted()
                            }
                        }
                    } else {
                        observer.onError(NSError(domain: "", code: 100, userInfo: nil))
                    }
                } catch {
                    observer.onError(NSError(domain: "", code: 100, userInfo: nil))
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - TournamentID-Recent
    static func fetchLOLLeagueTournamentIDRecent(url: URL) -> Observable<Int> {
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    if let response = response as? HTTPURLResponse {
                        let tmpError = NSError(domain: "", code: response.statusCode, userInfo: nil)
                        observer.onError(tmpError)
                    }
                    observer.onError(NSError(domain: "", code: 0, userInfo: nil))
                }
                do {
                    if let data = data {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        if let jsonDic = jsonObject as? [[String:Any]] {
                            if let json = jsonDic.first {
                                if let tournamentID = json["tournament_id"] as? Int {
                                    observer.onNext(tournamentID)
                                    
                                } else {
                                    observer.onError(NSError(domain: "", code: 100, userInfo: nil))
                                }
                            }
                            
                        } else {
                            observer.onError(NSError(domain: "", code: 100, userInfo: nil))
                        }
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(NSError(domain: "", code: 100, userInfo: nil))
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - TournamentID
    static func fetchLOLLeagueTournamentID(url: URL) -> Observable<(Int,Bool,Int)> {
        
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    if let response = response as? HTTPURLResponse {
                        let tmpError = NSError(domain: "", code: response.statusCode, userInfo: nil)
                        observer.onError(tmpError)
                    }
                    observer.onError(NSError(domain: "", code: 0, userInfo: nil))
                }
                var isFinish = false
                var curPage = 0
                var perPage = 0
                var total = 0
                if let response = response as? HTTPURLResponse{
                    if let headers = response.allHeaderFields as? [String:Any] {
                        curPage = Int(headers["x-page"] as! String) ?? 0
                        perPage = Int(headers["x-per-page"] as! String) ?? 0
                        total = Int(headers["x-total"] as! String) ?? 0

                        isFinish = (curPage * perPage) >= total
                    }
                }
                
                do {
                    if let leagues = data {
                        let jsonObject = try JSONSerialization.jsonObject(with: leagues, options: .allowFragments)
                        if let jsonDic = jsonObject as? [[String:Any]] {
                            var tmpData: [Int] = []
                            for league in jsonDic {
                                if let tournamentID = league["tournament_id"] as? Int {
                                    if !tmpData.contains(tournamentID){
                                        tmpData.append(tournamentID)
                                        observer.onNext((tournamentID, isFinish,curPage))
                                    }                                    
                                }
                            }
                        }
                        observer.onCompleted()
                    } else {
                        if let response = response as? HTTPURLResponse {
                            let tmpError = NSError(domain: "", code: response.statusCode, userInfo: nil)
                            print(response.statusCode)
                            observer.onError(tmpError)
                        }
                        observer.onError(NSError(domain: "", code: 100, userInfo: nil))
                    }
                } catch {
                    // catch error
                    let tmpError = NSError(domain: "", code: 1000, userInfo: nil)
                    observer.onError(tmpError)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - Team
    static func fetchLOLTeam(url: URL) -> Observable<Player> {
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                }
                do {
                    if let team = data {
                        let jsonObjes = try JSONSerialization.jsonObject(with: team, options: .allowFragments)
                        if let jsonDic = jsonObjes as? [String: Any] {
                            if let players = jsonDic["players"] as? [[String:Any]] {
                                for playerJson in players {
                                    let tmpPlayer = Player(jsonString: playerJson)
                                    observer.onNext(tmpPlayer)
                                }
                            }
                        }
                        observer.onCompleted()
                    }
                    else {
                        let tmpError = NSError(domain: "", code: 100, userInfo: nil)
                        observer.onError(tmpError)
                    }
                } catch {
                    let tmpError = NSError(domain: "", code: 1000, userInfo: nil)
                    observer.onError(tmpError)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - Opponent
    static func fetchLOLOpponent(url: URL) -> Observable<OpponentCell> {
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                }
                do {
                    if let team = data {
                        let jsonObjes = try JSONSerialization.jsonObject(with: team, options: .allowFragments)
                        if let jsonDic = jsonObjes as? [String:Any] {
                            if let opponents = jsonDic["opponents"] as? [[String:Any]] {
                                var tmpOpponents: [[Opponent]] = []
                                for opponent in opponents {
                                    if let players = opponent["players"] as? [[String:Any]] {
                                        var tmpOpponent: [Opponent] = []
                                        for playerJson in players {
                                            tmpOpponent.append(Opponent(opponentJson: playerJson))
                                        }
                                        tmpOpponent.sort { (player1, player2) -> Bool in
                                            return getRoleOrder(role: player1.role) < getRoleOrder(role: player2.role)
                                        }
                                        tmpOpponents.append(tmpOpponent)
                                    }
                                }

                                if let leftTeam = tmpOpponents.first, let rightTeam = tmpOpponents.last {
                                    let lessCount = leftTeam.count < rightTeam.count ? leftTeam.count : rightTeam.count                    
                                    for i in 0...lessCount-1 {
                                        observer.onNext(OpponentCell(playerLeft: leftTeam[i], playerRight: rightTeam[i]))
                                    }
                                    if leftTeam.count - lessCount > 0 {
                                        for i in lessCount...(leftTeam.count - 1) {
                                            observer.onNext(OpponentCell(playerLeft: leftTeam[i], playerRight: nil))
                                        }
                                    }
                                    
                                    if rightTeam.count - lessCount > 0 {
                                        for i in lessCount...(rightTeam.count - 1) {
                                            observer.onNext(OpponentCell(playerLeft: nil, playerRight: rightTeam[i]))
                                        }
                                    }
                                } else {
                                    let tmpError = NSError(domain: "", code: 100, userInfo: nil)
                                    observer.onError(tmpError)
                                }
                            }
                        }
                        observer.onCompleted()
                    }
                    else {
                        let tmpError = NSError(domain: "", code: 100, userInfo: nil)
                        observer.onError(tmpError)
                    }
                } catch {
                    let tmpError = NSError(domain: "", code: 1000, userInfo: nil)
                    observer.onError(tmpError)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - Bracket(LOLCalendar)
    static func fetchLOLBracket(url: URL, isError: Bool) -> Observable<LOLCalendar> {
        return Observable.create { observer in
            if isError{
                let tmpError = NSError(domain: "", code: 300, userInfo: nil)
                observer.onError(tmpError)
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                }
                do {
                    if let brackets = data {
                        let jsonObject = try JSONSerialization.jsonObject(with: brackets, options: .allowFragments)
                        if let jsonDic = jsonObject as? [[String:Any]] {
                            for calendarJson in jsonDic {
                                let tmpCalendar = LOLCalendar(calendarJson: calendarJson)
                                observer.onNext(tmpCalendar)
                            }
                        }
                        observer.onCompleted()
                    } else {
                        if let response = response as? HTTPURLResponse {
                            let tmpError = NSError(domain: "", code: response.statusCode, userInfo: nil)
                            observer.onError(tmpError)
                        }
                        observer.onError(NSError(domain: "", code: 100, userInfo: nil))
                    }
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - Image Download with Cache
    static func loadImage(url: URL) -> Observable<UIImage?> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let data = data,
                      let image = UIImage(data: data) else {
                    observer.onNext(nil)
                    observer.onCompleted()
                    return
                }
                
                observer.onNext(image)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
