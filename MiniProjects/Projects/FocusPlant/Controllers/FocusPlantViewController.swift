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
    @IBOutlet weak var pauseBotton: UIButton!
    @IBOutlet weak var stopBotton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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

//        startButton.isHidden = false
//        pauseBotton.isHidden = true
//        stopBotton.isHidden = true

        startButton.isHidden = true
        pauseBotton.isHidden = false
        stopBotton.isHidden = false

    }
}

// MARK: - Action
extension FocusPlantViewController {
    @IBAction func soundBottonPressed(_ sender: Any) {

    }

    @IBAction func startButtonPressed(_ sender: Any) {

    }
}
