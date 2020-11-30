//
//  DateUtils.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/30.
//

import Foundation

func dateToString(date: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    
    return dateFormatter.string(from: date)
}

func stringToDate(dateString date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
    return dateFormatter.date(from: date)
}
