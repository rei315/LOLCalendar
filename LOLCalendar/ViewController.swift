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
    
    let url = ""
    
    let bracketURLString = ""
    
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
}

