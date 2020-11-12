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
                            var team = Player()
                            if let players = jsonDic["players"] as? [[String:Any]] {
                                for player in players {
                                    
                                }
                            }
                        }
                    }
                } catch {
                    
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
                                        if let isFinish = game["finished"] as? String, isFinish == "True" {
                                            if let winner = game["winner"] as? [String:Any] {
                                                if let winnerID = winner["id"] as? Int {
                                                    calendar.score[winnerID]! += 1
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
