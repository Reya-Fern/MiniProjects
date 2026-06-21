//
//  CircularSliderView.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 19/6/2569 BE.
//

import UIKit

final class CircularSliderView: UIView {

    protocol CircularSliderViewDelegate: AnyObject {
        func circularSliderView(_ slider: CircularSliderView, didChangeMinutes minutes: Int)

    }

    weak var delegate: CircularSliderViewDelegate?

    private var progress:CGFloat = 0.75
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let thumpView = UIView()
    private var didSetupLayers = false

    private(set) var selectedMinutes = 10

    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

    override func layoutSubviews() {
        super.layoutSubviews()

        if !didSetupLayers {

            configureLayer()
            configureThump()
            configureGesture()

            didSetupLayers = true
        }
        updateThumpPosition()
    }
}

// MARK: - UI
extension CircularSliderView {
    private func configureLayer() {
        trackLayer.removeFromSuperlayer()
        progressLayer.removeFromSuperlayer()

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2

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

    private func configureThump() {
        thumpView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        thumpView.layer.cornerRadius = thumpView.bounds.width / 2
        thumpView.backgroundColor = .white

        thumpView.layer.shadowColor = UIColor.black.cgColor
        thumpView.layer.shadowOpacity = 0.15
        thumpView.layer.shadowRadius = 6
        thumpView.layer.shadowOffset = .init(width: 0, height: 2)

        addSubview(thumpView)
    }
}

// MARK: - Action
extension CircularSliderView {
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: self)

        updateProgress(from: point)
    }
}

// MARK: - Methods
extension CircularSliderView {
    private func updateThumpPosition() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2
        let angle = (-CGFloat.pi / 2) + (progress * 2 * .pi)
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)

        thumpView.center = CGPoint(x: x, y: y)
    }

    func setProgress(_ progress: CGFloat) {
        self.progress = max(0, min(progress, 1))

        progressLayer.strokeEnd = self.progress

        updateThumpPosition()
    }

    private func configureGesture() {
        addGestureRecognizer(tapGesture)
    }

    private func angle(for point: CGFloat) -> CGFloat {

        return 0
    }

    private func updateProgress(from point: CGPoint) {
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

        let progress = angle / (2 * .pi)

        updateMinutes(from: progress)
    }

    private func updateMinutes(from progress: CGFloat) {
        let minute = 10 + (progress * 110)
        let snapMinute = (round(minute / 5) * 5)

        selectedMinutes = Int(min(max(snapMinute, 10), 120))

        delegate?.circularSliderView(self, didChangeMinutes: selectedMinutes)

        let snapProgress = CGFloat(selectedMinutes - 10) / 110

        setProgress(snapProgress)
    }
}
