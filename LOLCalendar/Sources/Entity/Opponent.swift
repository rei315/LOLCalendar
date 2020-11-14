//
//  Opponent.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/14.
//

import Foundation

struct Opponent {
    let name: String
    let role: String
    let image_url: String
    
    init() {
        name = ""
        role = ""
        image_url = ""
    }
    
    init (name: String, role: String, image_url: String) {
        self.name = name
        self.role = role
        self.image_url = image_url
    }
}
