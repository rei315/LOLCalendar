//
//  Role.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/30.
//

import Foundation

enum Role: String{
    case top
    case jun
    case mid
    case adc
    case sup
}
func getRoleOrder(role: String) -> Int{
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
