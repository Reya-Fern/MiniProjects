//
//  FoodPricableProtocol.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 17/5/2569 BE.
//

import UIKit

protocol FoodPricable: AnyObject {
    var foodImage: UIImageView! { get }
    var nameLabel: UILabel! { get }
    var priceLabel: UILabel! { get }
}

extension FoodPricable {
    func configureFood(with item: FoodItem) {
        nameLabel.text = item.title
        priceLabel.text = "\(item.price) บาท"
        foodImage.image = UIImage(named: item.imageName)
    }
}

