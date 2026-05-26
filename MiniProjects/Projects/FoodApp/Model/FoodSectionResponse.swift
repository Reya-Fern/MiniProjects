//
//  FoodListData.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 26/5/2569 BE.
//

import Foundation

struct FoodSectionResponse: Codable {
    let heroItems: [FoodList]
    let categoryItems: [FoodList]
    let recommendedItems: [FoodList]
    let allItems: [FoodList]
}
