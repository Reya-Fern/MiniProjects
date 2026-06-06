//
//  ViewController.swift
//  Cute Calculator
//
//  Created by Wannipa Reya on 9/5/2569 BE.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var expressionLabel: UILabel!
    @IBOutlet var allButtons: [UIButton]!

    private let calculatorEngine = CalculatorEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()

        allButtons.forEach {
            $0.styleButtons()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        allButtons.forEach{
            $0.makeCircular()
        }
    }
}

//MARK: - Style
extension CalculatorViewController {

    private func style() {
        view.backgroundColor = .background
        containerView.backgroundColor = .background

        displayView.displayStyle()
        displayLabel.styleDisplayLabel()
        expressionLabel.styleExpressionLabel()
    }
}

//MARK: - Action
extension CalculatorViewController {

    @IBAction func calculatorButtonTapped(_ sender: UIButton) {
        let value =
        sender.titleLabel?.text ??
        sender.accessibilityIdentifier ??
        ""

        let state = calculatorEngine.handleInput(value)
        expressionLabel.text = state.expression
        displayLabel.text = state.display
    }
}
