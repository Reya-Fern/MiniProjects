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
    @IBOutlet var allButtons: [UIButton]!

    private let calculate = CalculatorEngine()

    override func viewDidLoad() {
        super.viewDidLoad()

        style()

        allButtons.forEach {
            $0.styleButtons()
        }

        displayLabel.styleLabel()
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
        displayView.backgroundColor = .clear
    }
}

//MARK: - Action
extension CalculatorViewController {

    @IBAction func calculatorButtonTapped(_ sender: UIButton) {
        let value =
        sender.titleLabel?.text ??
        sender.accessibilityIdentifier ??
        ""

        displayLabel.text = calculate.handleInput(value)
    }
}
