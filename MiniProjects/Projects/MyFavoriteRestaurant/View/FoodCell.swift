//
//  FoodCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 15/5/2569 BE.
//

import UIKit

class FoodCell: UICollectionViewCell {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .calculatorPink
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }

    func configure(with item: FoodItem) {
        nameLabel.text = item.title
        priceLabel.text = item.price + " บาท"
        foodImage.image = UIImage(named: item.imageName)
    }
}
