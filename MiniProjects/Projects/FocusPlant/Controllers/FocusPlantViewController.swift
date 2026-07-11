//
//  FocusPlantViewController.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 13/6/2569 BE.
//

import UIKit
import AVFoundation

final class FocusPlantViewController: UIViewController {

    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var motivationLabel: UILabel!
    @IBOutlet weak var treeContainerView: UIView!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var controllButtonStackView: UIStackView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var soundInstructionLabel: UILabel!
    @IBOutlet weak var circularSliderView: CircularSliderView!

    private var timer: Timer?
    private var motivationTimer: Timer?
    private var remainingSeconds = Constants.FocusPlant.startingRemainingSeconds
    private var totalSeconds = 0
    private var isPaused = false
    private var currentTreeStage: TreeStage?
    private var selectedActivity: Activity = .study
    private var selectedSound: AmbientSound = .forestRain
    private var isSoundEnable = false
    private var audioPlayer: AVAudioPlayer?
    private var wasSoundEnable = false

    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    let notificationFeedack = UINotificationFeedbackGenerator()

    private var currentState: FocusState = .setup {
        didSet {
            updateUI(for: currentState)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        circularSliderView.delegate = self

        setupUI()
        setUpGesture()
        updateTimerLabel()
        updateTreePreview(minutes: Int(Constants.FocusPlant.maximumMinutes))
        circularSliderView.setProgress(1)
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

        stopButton.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        stopButton.makeCircular()
        pauseButton.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        pauseButton.makeCircular()
    }

    private func updateUI(for state: FocusState) {
        switch state {
        case .setup:
            circularSliderView.isHidden = false
            startButton.isHidden = false
            controllButtonStackView.isHidden = true
            motivationLabel.text = Constants.FocusPlant.setUpMotivationQuote
        case .running:
            circularSliderView.isHidden = true
            startButton.isHidden = true
            controllButtonStackView.isHidden = false
            motivationLabel.text = Constants.FocusPlant.runningMotivationQuote
        case .paused:
            circularSliderView.isHidden = true
            startButton.isHidden = true
            controllButtonStackView.isHidden = false
            motivationLabel.text = Constants.FocusPlant.pausedMotivationQuote
        case .completed:
            circularSliderView.isHidden = true
            startButton.isHidden = false
            controllButtonStackView.isHidden = true
            motivationLabel.text = Constants.FocusPlant.completedMotivationQuote
        }
    }

    private func setUpGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(soundButtonLongPressed))

        soundButton.addGestureRecognizer(longPress)
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
    }

    @IBAction func activityButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: Constants.Alert.Title.selectActivity, message: nil, preferredStyle: .actionSheet)

        Activity.allCases.forEach {
            activity in

            let action = UIAlertAction(title: activity.rawValue, style: .default) { _ in
                self.selectedActivity = activity
                self.activityButton.setTitle(activity.rawValue, for: .normal)
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: Constants.Alert.ButtonTitle.cancel, style: .cancel))
        present(alert, animated: true)
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        guard currentState == .setup else { return }

        impactFeedback.impactOccurred()
        totalSeconds = remainingSeconds
        currentState = .running
        startTimer()
        startMotivationTimer()
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        showStopConfirmation()
    }

    @IBAction func pauseButtonPressed(_ sender: Any) {

        if isPaused {
            resumeSession()
        } else {
            pauseSession()
        }
    }

    @objc private func soundButtonLongPressed(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }

        showSoundPicker()
    }
}

// MARK: - Delegate
extension FocusPlantViewController: CompletePopupViewDelegate, CircularSliderViewDelegate {

    func circularSliderView(_ slider: CircularSliderView, didChangeMinutes minutes: Int) {
        remainingSeconds = minutes * 60

        updateTimerLabel()

        updateTreePreview(minutes: minutes)
    }

    func completePopupViewDidTapOK(_ popup: CompletePopupView) {
        popup.dismiss()
        resetToSetupStage()
    }
}

// MARK: - Timer
extension FocusPlantViewController {
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
                self.motivationTimer?.invalidate()

                self.currentState = .completed
                notificationFeedack.notificationOccurred(.success)
                self.stopSound()
                self.showCompletePopup()
            }
        }
    }

    private func updateTimerLabel() {
        let minutes: Int = remainingSeconds / 60
        let seconds: Int = remainingSeconds % 60

        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }

    private func startMotivationTimer() {
        motivationTimer?.invalidate()

        motivationTimer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [weak self] _ in
            self?.showRandomMotivation()
        }
    }
}

// MARK: - Sound
extension FocusPlantViewController {
    private func updateSoundButton() {
        let imageName = isSoundEnable ? "headphones" : "headphones.slash"

        soundButton.setImage(UIImage(systemName: imageName), for: .normal)
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

        isSoundEnable = true
        updateSoundButton()
        updateSoundLabel()
    }

    private func stopSound() {
        audioPlayer?.stop()
        isSoundEnable = false
        updateSoundButton()
        updateSoundLabel()
    }

    private func updateSoundLabel() {
        if isSoundEnable {
            soundNameLabel.isHidden = false
            soundInstructionLabel.isHidden = false
            soundNameLabel.text = Constants.FocusPlant.soundFirstLabel + " \"\(selectedSound.soundDisplayName)\""
            soundInstructionLabel.text = Constants.FocusPlant.soundSecondLabel
        } else {
            soundNameLabel.isHidden = true
            soundInstructionLabel.isHidden = true
        }
    }

    private func showSoundPicker() {
        let alert = UIAlertController(title: Constants.Alert.Title.selectBackgroundSound, message: nil, preferredStyle: .actionSheet)

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
        alert.addAction(UIAlertAction(title: Constants.Alert.ButtonTitle.cancel, style: .cancel))

        present(alert, animated: true)
    }
}

// MARK: - Tree Progress
extension FocusPlantViewController {
    private func updateTreePreview(minutes: Int) {
        let stage: TreeStage

        switch minutes {

        case 0..<10:
            stage = .stage1

        case 10..<60:
            stage = .stage2

        case 60..<90:
            stage = .stage3

        case 90..<120:
            stage = .stage4

        default:
            stage = .stage5

        }

        updateTreeImage(stage: stage,animated: false)
    }

    private func updateTreeGrowth() {
        guard totalSeconds > 0 else { return }

        let targetStage = targetTreeStage(for: totalSeconds / 60)

        let progress = Double(totalSeconds - remainingSeconds) / Double(totalSeconds)

        let stage: TreeStage

        switch targetStage {

        case .stage2:
            if progress < 0.25 {
                stage = .stage1
            } else {
                stage = .stage2
            }

        case .stage3:
            if progress < 0.33 {
                stage = .stage1
            } else if progress < 0.66 {
                stage = .stage2
            } else {
                stage = .stage3
            }
        case .stage4:
            if progress < 0.25 {
                stage = .stage1
            } else if progress < 0.5 {
                stage = .stage2
            } else if progress < 0.75 {
                stage = .stage3
            } else {
                stage = .stage4
            }
        case .stage5:
            if progress < 0.2 {
                stage = .stage1
            } else if progress < 0.4 {
                stage = .stage2
            } else if progress < 0.6 {
                stage = .stage3
            } else if progress < 0.8 {
                stage = .stage4
            } else {
                stage = .stage5
            }
        default:
            stage = .stage1
        }

        updateTreeImage(stage: stage, animated: true)
    }

    private func updateTreeImage(stage: TreeStage, animated: Bool) {
        guard stage != currentTreeStage else { return }

        currentTreeStage = stage

        let image = UIImage(named: stage.imageName)

        if animated {
            UIView.transition(with: treeImageView, duration: 0.3, options: .transitionCrossDissolve) {
                self.treeImageView.image = image
            }
        } else {
            treeImageView.image = image
        }
    }

    private func targetTreeStage(for minutes: Int) -> TreeStage {
        switch minutes {

        case 10..<60:
            return .stage2

        case 60..<90:
            return .stage3

        case 90..<120:
            return .stage4

        default:
            return .stage5
        }
    }
}

// MARK: - Session Flow
extension FocusPlantViewController {
    private func pauseSession() {
        timer?.invalidate()
        motivationTimer?.invalidate()
        isPaused = true
        pauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        currentState = .paused

        wasSoundEnable = isSoundEnable

        if isSoundEnable {
            stopSound()
        }
    }

    private func resumeSession() {
        startTimer()
        startMotivationTimer()
        isPaused = false
        pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
        currentState = .running

        if wasSoundEnable {
            playSelectedSound()
        }
    }

    private func resetToSetupStage() {
        timer?.invalidate()
        motivationTimer?.invalidate()

        totalSeconds = Constants.FocusPlant.startingRemainingSeconds
        remainingSeconds = totalSeconds
        updateTimerLabel()

        currentState = .setup

        updateTreePreview(minutes: totalSeconds / 60)

        circularSliderView.setProgress(1)

        isPaused = false
        pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)

        stopSound()
    }
}

// MARK: - Hepler
extension FocusPlantViewController {
    private func updateProgressRing() {
        let progress = CGFloat(remainingSeconds) / CGFloat(totalSeconds)
        circularSliderView.setProgress(progress)
    }

    private func showRandomMotivation() {
        guard let randomQuote = Constants.FocusPlant.allMotivationQuotes.randomElement() else { return }

        UIView.transition(with: motivationLabel, duration: 0.4, options: .transitionCrossDissolve) {
            self.motivationLabel.text = randomQuote
        }
    }

    private func showCompletePopup() {
        let popup = CompletePopupView.loadFromNib()
        popup.delegate = self
        popup.frame = view.bounds
        popup.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0)
        popup.cardView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.25) {
            popup.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.45)
            popup.cardView.transform = .identity
        }
        view.addSubview(popup)
    }

    private func showStopConfirmation() {
        let alert = UIAlertController(title: Constants.Alert.Title.stopPlanting, message: Constants.Alert.Message.lostSession, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: Constants.Alert.ButtonTitle.cancel, style: .cancel)

        let stopAction = UIAlertAction(title: Constants.Alert.ButtonTitle.stop, style: .destructive) { [weak self] _ in
            self?.notificationFeedack.notificationOccurred(.warning)
            self?.resetToSetupStage()
        }

        alert.addAction(cancelAction)
        alert.addAction(stopAction)

        present(alert, animated: true)
    }
}
