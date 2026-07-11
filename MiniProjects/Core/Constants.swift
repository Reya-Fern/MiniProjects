//
//  Constants.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 13/5/2569 BE.
//
import Foundation

enum Constants: String {
    case error = "Undefined"
    case homeTitle = "Mini Projects"

    enum focusPlant {
        static let allMotivationQuotes = [
            "One step at a time.",
            "Keep going!",
            "Deep work wins.",
            "Every minute counts.",
            "You're doing great!",
            "Progress over perfection.",
            "Small steps matter."
        ]
        static let setUpMotivationQuote = "Start planting today!"
        static let runningMotivationQuote = "Stay focused!"
        static let pausedMotivationQuote = "Take a short break"
        static let completedMotivationQuote = "Hooray! You've planted 1 healthy tree"

        // Circular Slider View
        static let minimumMinutes: CGFloat = 10
        static let maximumMinutes: CGFloat = 120
        static let minuteStep: CGFloat = 5
    }
}
