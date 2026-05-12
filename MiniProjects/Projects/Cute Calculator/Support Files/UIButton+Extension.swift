//
//  CalculatorButton.swift
//  Cute Calculator
//
//  Created by Wannipa Reya on 9/5/2569 BE.
//

import UIKit

extension UIButton {

    func styleButtons() {
        titleLabel?.font = .systemFont(
            ofSize: 34,
            weight: .medium
        )
        tintColor = .black
        clipsToBounds = true

        setButtonColor()
    }

    func makeCircular() {
        let cornerRadius = min(bounds.width, bounds.height) / 2
        layer.cornerRadius = cornerRadius

        if var config = configuration {
            config.background.cornerRadius = cornerRadius
            config.cornerStyle = .fixed

            configuration = config
        }
    }

    func setButtonColor() {
        let value =
        titleLabel?.text ??
        accessibilityIdentifier ??
        ""

        let color: UIColor

        switch value  {
        case CalButton.delete.rawValue, CalButton.ac.rawValue, CalButton.percent.rawValue:
            color = .calculatorPink
        case CalButton.seven.rawValue, CalButton.eight.rawValue, CalButton.nine.rawValue:
            color = .calculatorYellow
        case CalButton.four.rawValue, CalButton.five.rawValue, CalButton.six.rawValue:
            color = .calculatorGreen
        case CalButton.one.rawValue, CalButton.two.rawValue, CalButton.three.rawValue:
            color = .calculatorPurple
        case CalButton.plusMinus.rawValue,CalButton.zero.rawValue, CalButton.dot.rawValue:
            color = .calculatorBlue
        case CalButton.divide.rawValue, CalButton.multiply.rawValue, CalButton.minus.rawValue, CalButton.plus.rawValue, CalButton.equal.rawValue:
            color = .calculatorOrange
        default:
            color = .systemGray3
        }

        if var config = configuration {
            config.background.backgroundColor = color
            configuration = config
        }
    }
}
