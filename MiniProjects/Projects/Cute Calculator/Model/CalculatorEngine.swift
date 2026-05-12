//
//  CalculatorEngine.swift
//  Cute Calculator
//
//  Created by Wannipa Reya on 9/5/2569 BE.
//

import Foundation

final class CalculatorEngine {

    private var currentInput = "0"
    private var previousValue: Double = 0
    private var currentOperation: String?
    private var shouldStartNewInput = false
    private var hasError = false
    private let maxDigits = 12

    func handleInput(_ value: String) -> String {

        if hasError {
            clear()
            if value == CalButton.ac.rawValue {
                return currentInput
            }
        }

        switch value {
        case CalButton.zero.rawValue...CalButton.nine.rawValue:
            appendNumber(value)
        case CalButton.dot.rawValue:
            appendDecimal()
        case CalButton.ac.rawValue:
            clear()
        case CalButton.delete.rawValue:
            deleteLast()
        case CalButton.divide.rawValue, CalButton.multiply.rawValue, CalButton.minus.rawValue, CalButton.plus.rawValue:
            setOperation(value)
        case CalButton.equal.rawValue:
            calculate()
        case CalButton.percent.rawValue:
            convertToPercent()
        case CalButton.plusMinus.rawValue:
            toggleSign()
        default:
            break
        }

        return formattedDisplay
    }
}

//MARK: - Methods
extension CalculatorEngine {

    private func appendNumber (_ value: String) {
        if shouldStartNewInput {
            currentInput = value
            shouldStartNewInput = false
            return
        }

        let digitCount = currentInput
            .filter { $0.isNumber }
            .count
        guard digitCount < maxDigits else { return }

        if currentInput == "0" {
            currentInput = value
        } else {
            currentInput += value
        }
    }

    private func appendDecimal () {
        if shouldStartNewInput {
            currentInput = "0."
            shouldStartNewInput = false
            return
        }

        if !currentInput.contains(".") {
            currentInput.append(".")
        }
    }

    private func clear () {
        currentInput = "0"
        previousValue = 0
        currentOperation = nil
        shouldStartNewInput = false
        hasError = false
    }

    private func deleteLast () {
        guard currentInput != "0" else { return }

        currentInput.removeLast()

        if currentInput.isEmpty || currentInput == "-" {
            currentInput = "0"
        }
    }

    private func setOperation(_ Operation: String) {
        previousValue = Double(currentInput) ?? 0
        currentOperation = Operation
        shouldStartNewInput = true
    }

    private func calculate() {
        let currentValue = Double(currentInput) ?? 0
        guard let operation = currentOperation else { return }
        let result: Double

        switch operation {

        case CalButton.divide.rawValue:
            if currentValue == 0 {
                currentInput = Constants.error.rawValue
                hasError = true
                return
            }

            result = previousValue / currentValue

        case CalButton.multiply.rawValue:
            result = previousValue * currentValue
        case CalButton.minus.rawValue:
            result = previousValue - currentValue
        case CalButton.plus.rawValue:
            result = previousValue + currentValue
        default :
            return
        }

        currentInput = formatResult(result)
        currentOperation = nil
    }

    private func convertToPercent() {
        let value = (Double(currentInput) ?? 0) / 100

        currentInput = formatResult(value)
    }

    private func toggleSign() {
        let value = (Double(currentInput) ?? 0) * -1

        currentInput = formatResult(value)
    }

    private func formatResult(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        }

        return String(value)
    }

    private var formattedDisplay: String {

        if currentInput.contains("."),
           currentInput.last == "." {

            let value = String(currentInput.dropLast())

            guard let number = Double(value) else {
                return currentInput
            }

            return formatted(number) + "."
        }

        guard let number = Double(currentInput) else {
            return currentInput
        }

        return formatted(number)
    }

    private func formatted(_ value: Double) -> String {

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 10

        return formatter.string(from: NSNumber(value: value))
        ?? currentInput
    }
}
