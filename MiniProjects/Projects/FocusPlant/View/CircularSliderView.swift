//
//  CircularSliderView.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 19/6/2569 BE.
//

import UIKit

final class CircularSliderView: UIView {
    private var progress:CGFloat = 0.75
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let thumpView = UIView()
    private var didSetupLayers = false

    override func layoutSubviews() {
        super.layoutSubviews()

        if !didSetupLayers {

            configureLayer()
            configureThump()

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
}
