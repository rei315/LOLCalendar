//
//  Player.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/13.
//

import Foundation

struct Player {
    let name: String
    let first_name: String
    let last_name: String
    let role: String
    let birthYear: Int
    let image_url: String
    
    init() {
        name = ""
        first_name = ""
        last_name = ""
        role = ""
        birthYear = 0
        image_url = ""
    }
}
