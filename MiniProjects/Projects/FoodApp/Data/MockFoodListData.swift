//
//  FoodListMockData.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 20/5/2569 BE.
//

import Foundation

enum MockFoodListData {

    static let heroItems: [FoodList] = [
        FoodList(title: "สลัดผัก", price: "80", imageName: "salad"),
        FoodList(title: "ผัดไทย", price: "100", imageName: "pad_thai"),
        FoodList(title: "ข้าวเหนียวมะม่วง", price: "120", imageName: "mango_sticky_rice")
    ]

    static let categoryItems: [FoodList] = [
        FoodList(title: "ก๋วยเตี๋ยว", price: "", imageName: "noodles"),
        FoodList(title: "ข้าว", price: "", imageName: "rice"),
        FoodList(title: "ของหวาน", price: "", imageName: "cake"),
        FoodList(title: "เครื่องดื่ม", price: "", imageName: "bubble_tea"),
        FoodList(title: "ของทอด", price: "", imageName: "fries")
    ]

    static let recommendedItems: [FoodList] = [
        FoodList(title: "พิซซ่า", price: "250", imageName: "pizza"),
        FoodList(title: "เบอร์เกอร์", price: "180", imageName: "burger"),
        FoodList(title: "ราเมน", price: "150", imageName: "ramen"),
        FoodList(title: "ซูชิ", price: "390", imageName: "sushi")
    ]

    static let allItems: [FoodList] = [
        FoodList(title: "ผัดไทย", price: "100", imageName: "pad_thai"),
        FoodList(title: "ก๋วยเตี๋ยว", price: "120", imageName: "noodles"),
        FoodList(title: "ข้าวเปล่า", price: "20", imageName: "rice"),
        FoodList(title: "ข้าวผัดกะเพรา", price: "100", imageName: "pad_kaprao"),
        FoodList(title: "ราเมน", price: "150", imageName: "ramen"),
        FoodList(title: "พิซซ่า", price: "250", imageName: "pizza"),
        FoodList(title: "เบอร์เกอร์", price: "180", imageName: "burger"),
        FoodList(title: "มันฝรั่งทอด", price: "90", imageName: "fries"),
        FoodList(title: "เค้ก", price: "90", imageName: "cake"),
        FoodList(title: "ข้าวเหนียวมะม่วง", price: "120", imageName: "mango_sticky_rice"),
        FoodList(title: "ซูชิ", price: "390", imageName: "sushi"),
        FoodList(title: "ติ่มซำ", price: "150", imageName: "dimsum"),
        FoodList(title: "น้ำเปล่า", price: "10", imageName: "water"),
        FoodList(title: "ชานมไข่มุก", price: "90", imageName: "bubble_tea")
    ]
}
