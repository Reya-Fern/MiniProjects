//
//  FocusPlantViewController.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 13/6/2569 BE.
//

import UIKit

final class FocusPlantViewController: UIViewController {

    @IBOutlet weak var soundBotton: UIButton!
    @IBOutlet weak var motivationLabel: UILabel!
    @IBOutlet weak var treeContainerView: UIView!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var controllButtonStackView: UIStackView!
    @IBOutlet weak var pauseBotton: UIButton!
    @IBOutlet weak var stopBotton: UIButton!

    private var currentState: FocusState = .setup

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateUI(for: currentState)
    }
}

// MARK: - UI
extension FocusPlantViewController {
    private func setupUI() {
        view.backgroundColor = .focusAppBG
        motivationLabel.font = .systemFont(ofSize: 24, weight: .medium)

        treeContainerView.backgroundColor = .calculatorYellow
        treeContainerView.makeRounded(cornerRadius: 125)

        motivationLabel.text = "Start planting today!"

        treeImageView.image = UIImage(named: "sample_tree")

        activityButton.setTitle("Study", for: .normal)
        activityButton.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        activityButton.makeRounded(cornerRadius: 15)

        timerLabel.text = "90:00"
        timerLabel.font = .systemFont(ofSize: 72, weight: .ultraLight)

        startButton.backgroundColor = .greenButton
        startButton.layer.cornerRadius = 6
        startButton.layer.shadowColor = UIColor.greenButtonShadow.cgColor
        startButton.layer.shadowOffset = .init(width: 0, height: 4)
        startButton.layer.shadowOpacity = 1
        startButton.layer.shadowRadius = 0
        startButton.layer.masksToBounds = false

        stopBotton.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        stopBotton.makeCircular()
        pauseBotton.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        pauseBotton.makeCircular()
    }
}

// MARK: - Action
extension FocusPlantViewController {
    @IBAction func soundBottonPressed(_ sender: Any) {

    }

    @IBAction func startButtonPressed(_ sender: Any) {
        currentState = .running
        updateUI(for: currentState)
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        currentState = .setup
        updateUI(for: currentState)
    }

    @IBAction func pauseButtonPressed(_ sender: Any) {
        currentState = .paused
        updateUI(for: currentState)
    }
}

// MARK: - Method
extension FocusPlantViewController {
    private func updateUI(for state: FocusState) {
        switch state {
        case .setup:
            startButton.isHidden = false
            controllButtonStackView.isHidden = true
            motivationLabel.text = "Start planting today!"
        case .running:
            startButton.isHidden = true
            controllButtonStackView.isHidden = false
            motivationLabel.text = "Stay focused!"
        case .paused:
            startButton.isHidden = true
            controllButtonStackView.isHidden = false
            motivationLabel.text = "Take a short break"
        case .completed:
            startButton.isHidden = false
            controllButtonStackView.isHidden = true
            motivationLabel.text = "Great job!"
        }
    }
}
