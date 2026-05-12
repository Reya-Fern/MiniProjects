//
//  ProjectsModel.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 12/5/2569 BE.
//

enum ProjectType: CaseIterable {

    case calculator
    case favResturant

    var title: String {
        switch self {
        case .calculator:
            "Cute Calculator"
        case .favResturant:
            "My Favorite Resturant"
        }
    }

    var storyboardName: String {
        switch self {
        case .calculator:
            "Calculator"
        case .favResturant:
            "FavoriteResturant"
        }
    }

    var viewControllerID: String {
        switch self {
        case .calculator:
            "CalculatorVC"
        case .favResturant:
            "FavResturantVC"
        }
    }
}


