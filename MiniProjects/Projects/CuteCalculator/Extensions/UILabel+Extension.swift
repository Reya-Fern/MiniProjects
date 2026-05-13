//
//  UILabel+Extension.swift
//  Cute Calculator
//
//  Created by Wannipa Reya on 9/5/2569 BE.
//

import UIKit

extension UILabel {
    
    func styleLabel () {
        font = .systemFont(ofSize: 60, weight: .medium)
        backgroundColor = .background2
        layer.cornerRadius = 30
        clipsToBounds = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.3
        lineBreakMode = .byClipping
        numberOfLines = 1
    }
}
