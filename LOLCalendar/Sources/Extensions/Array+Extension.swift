//
//  Array+Extension.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/05.
//

import Foundation

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
