//
//  ProjectsModel.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 12/5/2569 BE.
//

enum ProjectType: CaseIterable {

    case calculator
    case favPlace

    var title: String {
        switch self {
        case .calculator:
            "Cute Calculator"
        case .favPlace:
            "My Favorite Place"
        }
    }

    var storyboardName: String {
        switch self {
        case .calculator:
            "Calculator"
        case .favPlace:
            "MyFavoritePlace"
        }
    }

    var storyboardID: String {
        switch self {
        case .calculator:
            "CalculatorVC"
        case .favPlace:
            "FavPlaceVC"
        }
    }
}


