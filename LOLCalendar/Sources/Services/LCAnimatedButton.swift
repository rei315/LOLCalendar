//
//  LCAnimatedButton.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/22.
//

import UIKit
import SnapKit

class LCAnimatedButton: UIButton {
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        phaseTwo(title: "Button", color: .darkGray)
    }
    
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        phaseTwo(title: title, color: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    fileprivate func phaseTwo(title: String, color: UIColor) {
        
        layer.cornerRadius = 5
        backgroundColor = color
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addTarget(self, action: #selector(down), for: .touchDown)
        addTarget(self, action: #selector(up), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc fileprivate func down() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.superview?.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func up() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.transform = .identity
            self.superview?.layoutIfNeeded()
        }
    }
    
    
}
