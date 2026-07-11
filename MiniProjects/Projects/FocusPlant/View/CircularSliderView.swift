//
//  CircularSliderView.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 19/6/2569 BE.
//

import UIKit

protocol CircularSliderViewDelegate: AnyObject {
    func circularSliderView(_ slider: CircularSliderView, didChangeMinutes minutes: Int)

}

final class CircularSliderView: UIView {

    weak var delegate: CircularSliderViewDelegate?

    private var currentProgress:CGFloat = 0.75
    private var draggingProgress: CGFloat = 0.75
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let thumbView = UIView()
    private var didSetupLayers = false
    private var lastAngle: CGFloat = 0
    private var isDragging = false
    private let selectionFeedback = UISelectionFeedbackGenerator()

    private(set) var selectedMinutes = 10

    private var radius: CGFloat {
        min(bounds.width, bounds.height) / 2
    }

    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))

    override func layoutSubviews() {
        super.layoutSubviews()

        if !didSetupLayers {

            configureLayer()
            configureThumb()
            configureGesture()

            didSetupLayers = true
        }
        setProgress(currentProgress)
    }
}

// MARK: - UI
extension CircularSliderView {
    private func configureLayer() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi / 2, endAngle: .pi * 3 / 2, clockwise: true)

        trackLayer.path = path.cgPath
        trackLayer.strokeColor = UIColor.white.withAlphaComponent(0.15)
            .cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 8
        trackLayer.lineCap = .round

        progressLayer.path = path.cgPath
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 8
        progressLayer.lineCap = .round

        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }

    private func configureThumb() {
        thumbView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        thumbView.layer.cornerRadius = thumbView.bounds.width / 2
        thumbView.backgroundColor = .white

        thumbView.layer.shadowColor = UIColor.black.cgColor
        thumbView.layer.shadowOpacity = 0.15
        thumbView.layer.shadowRadius = 6
        thumbView.layer.shadowOffset = .init(width: 0, height: 2)

        addSubview(thumbView)
    }
}

// MARK: - Action
extension CircularSliderView {
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {

        switch gesture.state {

        case .began:
            UIView.animate(withDuration: 0.15) {
                self.thumbView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            }

            draggingProgress = currentProgress

            let point = gesture.location(in: self)
            lastAngle = angle(from: point)

            selectionFeedback.prepare()

        case .changed:
            let point = gesture.location(in: self)
            let currentAngle = angle(from: point)
            var delta = currentAngle - lastAngle

            if delta > .pi {
                delta -= 2 * .pi
            }

            if delta < -.pi {
                delta += 2 * .pi
            }

            lastAngle = currentAngle

            draggingProgress += delta / (2 * .pi)
            draggingProgress = min(max(draggingProgress, 0), 1)

            let minutes = snappedMinutes(from: draggingProgress)
            setSelectedMinutes(minutes)

        case .ended, .cancelled, .failed:
            UIView.animate(withDuration: 0.15) {
                self.thumbView.transform = .identity
            }

        default:
            break
        }
    }
}

// MARK: - Methods
extension CircularSliderView {
    private func updateThumbPosition() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let angle = (-CGFloat.pi / 2) + (currentProgress * 2 * .pi)
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)

        thumbView.center = CGPoint(x: x, y: y)
    }

    func setProgress(_ progress: CGFloat) {
        self.currentProgress = max(0, min(progress, 1))

        progressLayer.strokeEnd = self.currentProgress

        updateThumbPosition()
    }

    private func configureGesture() {
        thumbView.addGestureRecognizer(panGesture)
        thumbView.isUserInteractionEnabled = true
    }

    private func progress(from point: CGPoint) -> CGFloat {
        angle(from: point) / (2 * .pi)
    }

    private func angle(from point: CGPoint) -> CGFloat {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        let dx = point.x - center.x
        let dy = point.y - center.y

        var angle = atan2(dy, dx)

        if angle < 0 {
            angle += 2 * .pi
        }
        angle += .pi / 2

        if angle > 2 * .pi {
            angle -= 2 * .pi
        }

        return angle
    }

    private func setSelectedMinutes(_ minutes: Int) {
        guard selectedMinutes != minutes else { return }

        selectionFeedback.selectionChanged()

        selectedMinutes = minutes

        delegate?.circularSliderView(self, didChangeMinutes: minutes)

        let progress = CGFloat(minutes - 10) / 110

        setProgress(progress)
    }

    private func snappedMinutes(from progress: CGFloat) -> Int {
        let minute = 10 + (progress * 110)
        let snapMinute = Int(round(minute / 5) * 5)

        return Int(min(max(snapMinute, 10), 120))
    }
}
