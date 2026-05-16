//
//  CategoryCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 16/5/2569 BE.
//

import UIKit

final class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
}

//MARK: - UI
extension CategoryCell {
    func configure(with item: FoodItem) {
        nameLabel.text = item.title
        foodImage.image = UIImage(named: item.imageName)
    }

    private func style() {
        contentView.backgroundColor = .clear
        foodImage.makeRounded(cornerRadius: foodImage.bounds.width / 2)
        imageContainer.backgroundColor = .calculatorBlue
        imageContainer.makeRounded(cornerRadius: imageContainer.bounds.width / 2)
    }
}
