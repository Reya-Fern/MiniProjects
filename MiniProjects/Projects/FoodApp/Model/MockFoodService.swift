//
//  MockFoodService.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 26/5/2569 BE.
//

import Foundation

final class MockFoodService {

    static let shared = MockFoodService()

    private init() {}

    func fetchFoodData() -> FoodSectionResponse? {
        guard let url = Bundle.main.url(forResource: "MockFood", withExtension: "json") else {
            print("❌ Cannot find MockFood.json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(FoodSectionResponse.self,from: data)

            return response

        } catch {
            print("❌ Decode Error:", error)
            return nil
        }
    }
}
