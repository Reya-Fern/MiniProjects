//
//  UILabel+Extension.swift
//  Cute Calculator
//
//  Created by Wannipa Reya on 9/5/2569 BE.
//

import UIKit

extension UILabel {
    
    func styleDisplayLabel() {
        font = .systemFont(ofSize: 60, weight: .medium)
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.3
        lineBreakMode = .byClipping
        numberOfLines = 1
        textAlignment = .right
    }
    
    func styleExpressionLabel() {
        font = .systemFont(ofSize: 28, weight: .regular)
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.3
        lineBreakMode = .byClipping
        numberOfLines = 1
        textAlignment = .right
    }
}
