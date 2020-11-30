//
//  Opponent.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/14.
//

import Foundation

struct Opponent {
    // MARK: - Property
    
    let name: String
    let role: String
    var image_url: URL?
    
    // MARK: - Initialize
    
    init() {
        name = ""
        role = ""
        image_url = URL(string: "")
    }
    
    init (name: String, role: String, image_url: URL) {
        self.name = name
        self.role = role
        self.image_url = image_url
    }
    
    init (opponentJson json: [String:Any]) {
        self.name = json["name"] as? String ?? ""
        self.role = json["role"] as? String ?? ""
        if let url = URL(string: json["image_url"] as? String ?? "") {
            self.image_url = url
        }
    }
}
