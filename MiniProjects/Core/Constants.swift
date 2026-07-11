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

    enum Alert {
        enum Title {
            static let selectActivity = "Select Activity"
            static let selectBackgroundSound = "Slect Background Sound"
            static let stopPlanting = "Stop planting?"
        }

        enum Message {
            static let lostSession = "Your current focus session will be lost."
        }

        enum ButtonTitle {
            static let cancel = "Cancel"
            static let stop = "Stop"
        }
    }

    enum FocusPlant {
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

        static let soundFirstLabel = "Playing:"
        static let soundSecondLabel = "(Tap and hold the icon to change sounds)"

        static let startingRemainingSeconds = 7200

        // Circular Slider View
        static let minimumMinutes: CGFloat = 10
        static let maximumMinutes: CGFloat = 120
        static let minuteStep: CGFloat = 5
    }
}
