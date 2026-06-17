//
//  AmbientSound.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 17/6/2569 BE.
//

enum AmbientSound: String, CaseIterable {
    case forestRain
    case rain
    case forest
    case coffee
    case ocean

    var soundDisplayName: String {
        switch self {
        case .forestRain: 
            return "Forest Rain"
        case .rain: 
            return "Rain"
        case .forest: 
            return "Forest"
        case .coffee: 
            return "Coffee Shop"
        case .ocean: 
            return "Ocean"
        }
    }
}
