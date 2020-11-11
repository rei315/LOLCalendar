//
//  AlertAction.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/12.
//

import UIKit

struct AlertAction {
    var title: String
    var style: UIAlertAction.Style

    static func action(title: String, style: UIAlertAction.Style = .default) -> AlertAction {
        return AlertAction(title: title, style: style)
    }
}
