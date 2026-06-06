//
//  CalculatorEngine.swift
//  Cute Calculator
//
//  Created by Wannipa Reya on 9/5/2569 BE.
//

import Foundation

final class CalculatorEngine {

    struct CalculatorState {
        let expression: String
        let display: String
    }

    private var currentInput = "0"
    private var previousValue: Double = 0
    private var currentOperation: String?
    private var shouldStartNewInput = false
    private var hasError = false
    private let maxDigits = 12
    private var expression = ""

    func handleInput(_ value: String) -> CalculatorState {

        if hasError {
            clear()
            if value == CalButton.ac.rawValue {
                return CalculatorState(expression: expression, display: currentInput)
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

        return CalculatorState(expression: expression, display: formattedDisplay)
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

        if let operation = currentOperation {
            expression = "\(formatResult(previousValue))\(operatorSymbol(for: operation))\(currentInput)"
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
        expression = ""
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

    private func setOperation(_ operation: String) {
        previousValue = Double(currentInput) ?? 0
        currentOperation = operation
        shouldStartNewInput = true
        expression = "\(formattedDisplay)\(operatorSymbol(for: operation))"
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

        expression = "\(formatResult(previousValue))\(operatorSymbol(for: operation))\(currentInput)"
        currentInput = formatResult(result)
        currentOperation = nil
    }

    private func convertToPercent() {
        let value = (Double(currentInput) ?? 0) / 100

        expression = "\(currentInput)%"
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
    
    private func operatorSymbol(for operation: String) -> String {

        switch operation {
        case CalButton.divide.rawValue:
            return "÷"
        case CalButton.multiply.rawValue:
            return "×"
        case CalButton.minus.rawValue:
            return "−"
        case CalButton.plus.rawValue:
            return "+"
        default:
            return operation
        }
    }
}
