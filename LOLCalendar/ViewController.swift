//
//  ViewController.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/04.
//

import UIKit
import RxSwift
import NSObject_Rx
import RxCocoa

class ViewController: UIViewController {
    
    let url = "https://api.pandascore.co/leagues/293/matches?token=6pZk6i_t5FHDEVoJCBFW_saGZOeI0452Ye87ib8yH-zt3PbNs98&range[begin_at]=2020-01-01T00:00:00Z,2020-12-31T23:59:59Z"
    
    let bracketURLString = "https://api.pandascore.co/tournaments/%d/brackets?token=6pZk6i_t5FHDEVoJCBFW_saGZOeI0452Ye87ib8yH-zt3PbNs98"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        test00()
    }
    
    func test00(){
//        let tournamentIds = APIService.fetchTournamentID(url: URL(string: url)!).share()
//        let allBranckets = tournamentIds
//            .map{ $0.tournamentID }
//            .flatMap { id in
//                APIService.fetchBracket(id: id)
//            }
//            .toArray()
//            .subscribe { print($0) }

    }
    
    //https://api.pandascore.co/teams/2882?token=6pZk6i_t5FHDEVoJCBFW_saGZOeI0452Ye87ib8yH-zt3PbNs98
}

