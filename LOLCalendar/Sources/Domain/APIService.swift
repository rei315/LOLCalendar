//
//  APIService.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation
import RxSwift
import RxCocoa

public enum TeamDirection: Int {
    case Left, Right
}

class APIService {
    
    static func fetchLOLLeagueTournamentID(url: URL) -> Observable<(Int,Bool,Int)> {
        
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
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
    
    static func fetchLOLTeam(url: URL, direction: TeamDirection) -> Observable<Player> {
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
                                for player in players {
                                    let name: String = player["name"] as? String ?? ""
                                    let first_name: String = player["first_name"] as? String ?? ""
                                    let last_name: String = player["last_name"] as? String ?? ""
                                    let role: String = player["role"] as? String ?? ""
                                    let birthYear: Int = player["birth_year"] as? Int ?? 0
                                    let image_url: String = player["image_url"] as? String ?? ""
                                    
                                    let tmpPlayer = Player(id: direction.rawValue,name: name, first_name: first_name, last_name: last_name, role: role, birthYear: birthYear, image_url: image_url)
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
    enum Role: String{
        case top
        case jun
        case mid
        case adc
        case sup
    }
    static func getRoleOrder(role: String) -> Int{
        switch role {
        case Role.top.rawValue:
            return 0
        case Role.jun.rawValue:
            return 1
        case Role.mid.rawValue:
            return 2
        case Role.mid.rawValue:
            return 3
        case Role.adc.rawValue:
            return 4
        case Role.sup.rawValue:
            return 5
        default:
            return 0
        }
    }
    
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
                                        for player in players {
                                            let name = player["name"] as? String ?? ""
                                            let role = player["role"] as? String ?? ""
                                            let image_url = player["image_url"] as? String ?? ""
                                            tmpOpponent.append(Opponent(name: name, role: role, image_url: image_url))
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
                            for bracket in jsonDic {
                                var calendar = LOLCalendar()
                                                                
                                // ID
                                if let id = bracket["id"] as? Int {
                                    calendar.id = id
                                }
                                
                                // Scheduled_At
                                if let schedule = bracket["scheduled_at"] as? String {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.locale = Locale(identifier: "ko_KR")
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                                    if let date = dateFormatter.date(from: schedule) {
                                        calendar.scheduleAt = date
                                    }
                                }
                                
                                // Opponents
                                if let opponets = bracket["opponents"] as? [[String:Any]] {
                                    for opponent in opponets {
                                        if let element = opponent["opponent"] as? [String:Any] {
                                            let team = OpponentTeam(id: element["id"] as! Int, name: element["acronym"] as! String, logoURL: element["image_url"] as! String)
                                            calendar.opponents.append(team)
                                        }
                                    }
                                }
                                
                                // Winner
                                if let winner = bracket["winner_id"] as? Int {
                                    calendar.winnner = winner
                                }
                                
                                // Score
                                if let games = bracket["games"] as? [[String:Any]] {
                                    for game in games {
                                        if let isFinish = game["status"] as? String, isFinish == "finished" {
                                            if let winner = game["winner"] as? [String:Any] {
                                                if let winnerID = winner["id"] as? Int {
                                                    if calendar.score[winnerID] != nil {
                                                        calendar.score.updateValue(calendar.score[winnerID]! + 1, forKey: winnerID)
                                                    } else {
                                                        calendar.score.updateValue(1, forKey: winnerID)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                observer.onNext(calendar)
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
