//
//  FocusPlantViewController.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 13/6/2569 BE.
//

import UIKit
import AVFoundation

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
    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var soundInstructionLabel: UILabel!
    @IBOutlet weak var circularSliderView: CircularSliderView!

    private var currentState: FocusState = .setup
    private var timer: Timer?
    private var motivationTimer: Timer?
    private var remainingSeconds = 10
    private var totalSeconds = 10
    private var isPaused = false
    private var currentTreeStage: Int = 1
    private var selectedActivity: Activity = .study
    private var selectedSound: AmbientSound = .forestRain
    private var isSoundEnable = false
    private var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateUI(for: currentState)
        updateTimerLabel()
        updateSoundLabel()
        circularSliderView.setProgress(1)
    }
}

// MARK: - UI
extension FocusPlantViewController {
    private func setupUI() {
        view.backgroundColor = .focusAppBG
        motivationLabel.font = .systemFont(ofSize: 24, weight: .medium)

        treeContainerView.backgroundColor = .calculatorYellow
        treeContainerView.makeRounded(cornerRadius: 125)

        treeImageView.image = UIImage(named: "tree_stage_1")

        activityButton.setTitle(selectedActivity.rawValue, for: .normal)
        activityButton.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        activityButton.makeRounded(cornerRadius: 15)

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
    @IBAction func soundButtonPressed(_ sender: Any) {
        isSoundEnable.toggle()

        if isSoundEnable {
            playSelectedSound()
        } else {
            stopSound()
        }
        updateSoundButton()
        updateSoundLabel()

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(soundButtonLongPressed))
        soundBotton.addGestureRecognizer(longPress)
    }

    @IBAction func activityButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Select Activity", message: nil, preferredStyle: .actionSheet)

        Activity.allCases.forEach {
            activity in

            let action = UIAlertAction(title: activity.rawValue, style: .default) { _ in
                self.selectedActivity = activity
                self.activityButton.setTitle(activity.rawValue, for: .normal)
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        totalSeconds = remainingSeconds
        currentState = .running
        updateUI(for: currentState)
        startTimer()
        startMotivationTimer()
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        timer?.invalidate()
        motivationTimer?.invalidate()
        remainingSeconds = totalSeconds
        updateTimerLabel()
        currentState = .setup
        updateUI(for: currentState)
        isPaused = false
        pauseBotton.setImage(UIImage(systemName: "pause"), for: .normal)
        stopSound()
        isSoundEnable = false
        updateSoundButton()
        updateSoundLabel()
    }

    @IBAction func pauseButtonPressed(_ sender: Any) {
        if isPaused {
            startTimer()
            startMotivationTimer()
            isPaused = false
            pauseBotton.setImage(UIImage(systemName: "pause"), for: .normal)
            currentState = .running
        } else {
            timer?.invalidate()
            motivationTimer?.invalidate()
            isPaused = true
            pauseBotton.setImage(UIImage(systemName: "play"), for: .normal)
            currentState = .paused
        }
        updateUI(for: currentState)
        stopSound()
        isSoundEnable = false
        updateSoundButton()
        updateSoundLabel()
    }
}

// MARK: - Delegate
extension FocusPlantViewController: CompletePopupView.CompletePopupViewDelegate {
    func completePopupViewDidTapOK(_ popup: CompletePopupView) {

        popup.dismiss()

        remainingSeconds = totalSeconds
        updateTimerLabel()
        currentState = .setup
        updateUI(for: currentState)
    }
}

// MARK: - Method
extension FocusPlantViewController {
    private func updateUI(for state: FocusState) {
        switch state {
        case .setup:
            circularSliderView.isHidden = false
            startButton.isHidden = false
            controllButtonStackView.isHidden = true
            motivationLabel.text = Constants.fucusPlant.setUpMotivationQuote
        case .running:
            circularSliderView.isHidden = true
            startButton.isHidden = true
            controllButtonStackView.isHidden = false
            motivationLabel.text = Constants.fucusPlant.runningMotivationQuote
        case .paused:
            circularSliderView.isHidden = true
            startButton.isHidden = true
            controllButtonStackView.isHidden = false
            motivationLabel.text = Constants.fucusPlant.pausedMotivationQuote
        case .completed:
            startButton.isHidden = false
            controllButtonStackView.isHidden = true
            motivationLabel.text = Constants.fucusPlant.completedMotivationQuote
            motivationTimer?.invalidate()
            showCompletePopup()
        }
    }

    private func updateTimerLabel() {
        let minutes: Int = remainingSeconds / 60
        let seconds: Int = remainingSeconds % 60

        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }

    private func startTimer() {

        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1,repeats: true) {
            [weak self] _ in

            guard let self = self else { return }

            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
                self.updateTimerLabel()
                self.updateTreeGrowth()
            } else {
                self.timer?.invalidate()
                self.currentState = .completed
                self.updateUI(for: currentState)
            }
        }
    }

    private func updateTreeGrowth() {
        let progress = Double(totalSeconds - remainingSeconds) / Double(totalSeconds)
        let newstage: Int

        if progress < 0.25 {
            treeImageView.image = UIImage(named: "tree_stage_1")
            newstage = 1
        } else if progress < 0.5 {
            treeImageView.image = UIImage(named: "tree_stage_2")
            newstage = 2
        } else if progress < 0.75 {
            treeImageView.image = UIImage(named: "tree_stage_3")
            newstage = 3
        } else {
            treeImageView.image = UIImage(named: "tree_stage_4")
            newstage = 4
        }
        guard newstage != currentTreeStage else { return }
        currentTreeStage = newstage

        UIView.transition(with: treeImageView, duration: 0.3, options: .transitionCrossDissolve) {
            self.treeImageView.image = UIImage(named: "tree_stage_\(newstage)")
        }
    }

    private func startMotivationTimer() {
        motivationTimer?.invalidate()

        motivationTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            self?.showRandomMotivation()
        }
    }

    private func showRandomMotivation() {
        guard let randomQuote = Constants.fucusPlant.allMotivationQuotes.randomElement() else { return }

        UIView.transition(with: motivationLabel, duration: 0.4, options: .transitionCrossDissolve) {
            self.motivationLabel.text = randomQuote
        }
    }

    @objc private func soundButtonLongPressed(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }

        showSoundPicker()
    }

    private func showSoundPicker() {
        let alert = UIAlertController(title: "Slect Background Sound", message: nil, preferredStyle: .actionSheet)

        AmbientSound.allCases.forEach { sound in

            let action = UIAlertAction(title: sound.soundDisplayName, style: .default) { _ in

                self.selectedSound = sound

                if self.isSoundEnable {
                    self.playSelectedSound()
                    self.updateSoundLabel()
                }
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "Calcel", style: .cancel))

        present(alert, animated: true)
    }

    private func updateSoundButton() {
        let imageName = isSoundEnable ? "headphones" : "headphones.slash"

        soundBotton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    private func playSelectedSound() {
        guard let url = Bundle.main.url(forResource: selectedSound.rawValue, withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }

    private func stopSound() {
        audioPlayer?.stop()
    }

    private func updateSoundLabel() {
        if isSoundEnable {
            soundNameLabel.isHidden = false
            soundInstructionLabel.isHidden = false
            soundNameLabel.text = "Playing: \"\(selectedSound.soundDisplayName)\""
            soundInstructionLabel.text = "(Tap and hold the icon to change sounds)"
        } else {
            soundNameLabel.isHidden = true
            soundInstructionLabel.isHidden = true
        }
    }

    private func updateProgressRing() {
        let progress = CGFloat(remainingSeconds) / CGFloat(totalSeconds)
        circularSliderView.setProgress(progress)
    }

    private func showCompletePopup() {
        let popup = CompletePopupView.loadFromNib()
        popup.delegate = self
        popup.frame = view.bounds
        popup.alpha = 0
        popup.cardView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.25) {
            popup.alpha = 1
            popup.cardView.transform = .identity
        }
        view.addSubview(popup)
    }
}
