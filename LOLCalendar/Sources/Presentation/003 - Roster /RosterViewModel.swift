//
//  RosterViewModel.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/07.
//

import Foundation
import RxSwift
import RxCocoa
import Action

protocol RosterModelBindable {
    var topCellData: Driver<[RosterTopCell.Data]> { get }
}

struct TeamID {
    let team: [Int:Int]
}

class RosterViewModel: CommonViewModel, RosterModelBindable {
    var topCellData: Driver<[RosterTopCell.Data]>
    
    let disposeBag = DisposeBag()
    
    private var idDatas = BehaviorSubject<[TeamID]>(value: [])
    
    private var topCells = BehaviorRelay<[RosterTop]>(value: [])
    private var midCells = BehaviorRelay<RosterMid?>(value: nil)
    
    private var bottomCells = BehaviorRelay<[Player]>(value: [])
    
    private var rosterData = BehaviorSubject<[Roster]>(value: [])
    
    lazy var topCellAction: Action<Int, Void> = {
        return Action { id in
            Observable.just(self.switchSelectedTeam(id: id)).map { _ in }
        }
    }()
    
    func switchSelectedTeam(id: Int){
        do {
            if let roster = try rosterData.value().first(where: { (roster) -> Bool in
                return roster.id == id
            }) {
                bottomCells.accept(roster.players)
                midCells.accept(RosterMid(acronym: roster.acronym, name: roster.name, imageURL: roster.imageURL))
            }
        } catch {
            print("Error")
        }
    }
    
    init(leagueType: Int ,sceneCoordinator: SceneCoordinatorType, model: RosterModel = RosterModel()) {

        let tournamentID = model.getTournamentID(leagueID: leagueType)
            .catchError { (error) -> Observable<Int> in
                return .just(-1)
            }
            .share()

        let roster = tournamentID
            .flatMap {
                model.getRosters(tournamentID: $0)
            }
            .catchError { (error) -> Observable<Roster> in
                let tmpRoster = Roster()
                return .just(tmpRoster)
            }
            .toArray()
            .asObservable()
        
        let _ = roster
            .bind(to: rosterData)
            .disposed(by: disposeBag)
        
        // Top
        let _ = roster
            .flatMap { Observable.from($0) }
            .flatMap { (roster) -> Observable<RosterTop> in
                return Observable.just(RosterTop(id: roster.id, acronym: roster.acronym, imageURL: roster.imageURL))
            }
            .toArray()
            .asObservable()
            .bind(to: topCells)
        
        self.topCellData = topCells
            .map(model.parseTopCell)
            .asDriver(onErrorDriveWith: .empty())
        
        
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
