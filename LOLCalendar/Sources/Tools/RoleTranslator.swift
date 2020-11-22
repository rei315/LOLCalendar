//
//  RoleTranslator.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/22.
//

import Foundation

class RoleTranslator {
    static func translate(role roleStr: String) -> String{
        switch roleStr{
        case "top":
            return "탑"
        case "jun":
            return "정글"
        case "mid":
            return "미드"
        case "adc":
            return "원딜"
        case "sup":
            return "서폿"
        default:
            return roleStr
        }
    }
}
