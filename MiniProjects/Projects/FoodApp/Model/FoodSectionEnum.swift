//
//  FoodAppEnum.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 20/5/2569 BE.
//

import Foundation

enum FoodSection: Int, CaseIterable {
    case hero
    case categories
    case recommended
    case all

    var title: String {

        switch self {
        case .hero:
            return "แนะนำพิเศษ"
        case .categories:
            return "หมวดหมู่"
        case .recommended:
            return "เมนูยอดนิยม"
        case .all:
            return "เมนูทั้งหมด"
        }
    }

    var itemSize: CGSize {

        switch self {
        case .hero:
            return CGSize(width: 300, height: 150)
        case .categories:
            return CGSize(width: 80, height: 100)
        case .recommended:
            return CGSize(width: 115, height: 165)
        case .all:
            return CGSize(width: 180, height: 90)
        }
    }
}
