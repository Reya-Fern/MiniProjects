//
//  CategoryCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 16/5/2569 BE.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImageContentView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        style()
    }
}

//MARK: - Methods
extension CategoryCell {
    func configure(with item: FoodItem) {
        categoryName.text = item.title
        categoryImage.image = UIImage(named: item.imageName)
    }

    private func style() {
        contentView.backgroundColor = .clear

        categoryImage.layer.cornerRadius = categoryImage.bounds.width / 2
        categoryImage.clipsToBounds = true

        categoryImageContentView.backgroundColor = .calculatorBlue
        categoryImageContentView.layer.cornerRadius = categoryImageContentView.bounds.width / 2
    }
}
