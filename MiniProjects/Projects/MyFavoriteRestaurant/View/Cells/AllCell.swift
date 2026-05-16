//
//  allCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 16/5/2569 BE.
//

import UIKit

class AllCell: UICollectionViewCell {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var foodImageContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        style()
    }
}

//MARK: - Methods
extension AllCell {
    func configure(with item: FoodItem) {
        nameLabel.text = item.title
        priceLabel.text = item.price + " บาท"
        foodImage.image = UIImage(named: item.imageName)
    }

    private func style() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor

        foodImageContainer.backgroundColor = .calculatorGreen
        foodImageContainer.layer.cornerRadius = 20
        foodImageContainer.clipsToBounds = true
    }
}
