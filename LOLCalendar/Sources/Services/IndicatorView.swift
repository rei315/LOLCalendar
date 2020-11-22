//
//  IndicatorView.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/21.
//

import UIKit

class IndicatorView {
    var container = UIView()
    var loadingView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    static let shared: IndicatorView = {
        return IndicatorView()
        
    }()
    func show(parentView: UIView) {
        container.frame = parentView.frame
        container.center = parentView.center
        container.backgroundColor = UIColor(white: 0x000000, alpha: 0.3)
        loadingView.frame = CGRect(x:0, y:0, width:100, height:100)
        loadingView.center = parentView.center
        loadingView.backgroundColor = UIColor.black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x:0, y:0, width:40, height:40)
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2, y:loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        parentView.addSubview(container)
        activityIndicator.startAnimating()
        
    }
    func show() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            if #available(iOS 10.0, *) { window.layoutIfNeeded() }
            DispatchQueue.main.async {
                self.show(parentView:window)
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.container.removeFromSuperview()
        }
    }
}

