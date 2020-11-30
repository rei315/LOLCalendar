//
//  Player.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/13.
//

import Foundation

struct Player: Equatable, Hashable {
    // MARK: - Property
    
    let name: String
    let first_name: String
    let last_name: String
    var role: String?
    let birthYear: Int
    let image_url: String
    
    // MARK: - Initialize
    
    init() {
        name = ""
        first_name = ""
        last_name = ""
        role = ""
        birthYear = 0
        image_url = ""
    }
    
    init (jsonString json: [String:Any]) {
        self.name = json["name"] as? String ?? ""
        self.first_name = json["first_name"] as? String ?? ""
        self.last_name = json["last_name"] as? String ?? ""
        self.role = json["role"] as? String ?? ""
        self.birthYear = json["birth_year"] as? Int ?? 0
        self.image_url = json["image_url"] as? String ?? ""
    }
    init (name: String , first_name: String, last_name: String, role: String, birthYear: Int, image_url: String) {
        self.name = name
        self.first_name = first_name
        self.last_name = last_name
        self.role = RoleTranslator.translate(role: role)
        self.birthYear = birthYear
        self.image_url = image_url
    }
}
