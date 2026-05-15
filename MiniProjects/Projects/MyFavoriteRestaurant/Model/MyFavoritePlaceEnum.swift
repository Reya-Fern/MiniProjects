//
//  MyFavoritePlaceEnum.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 15/5/2569 BE.
//

enum Section: Int, CaseIterable {
    case hero
    case categories
//    case recommended
//    case all

    var title: String {
        switch self {
        case .hero: return "แนะนำพิเศษ"
        case .categories: return "หมวดหมู่"
//        case .recommended: return "เมนูยอดนิยม"
//        case .all: return "เมนูทั้งหมด"
        }
    }
}
