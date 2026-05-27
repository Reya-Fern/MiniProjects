//
//  FoodCategoryCellCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 27/5/2569 BE.
//

import UIKit

final class FoodCategoryCell: UICollectionViewCell {

    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        stlye()
    }
}

// MARK: - UI
extension FoodCategoryCell {
    private func stlye() {
        image.makeRounded(cornerRadius: image.bounds.width / 2)
        imageContainer.backgroundColor = .calculatorBlue
        imageContainer.makeRounded(cornerRadius: imageContainer.bounds.width / 2)
    }

    func configure (with item: FoodList) {
        image.image = UIImage(named: item.imageName)
        nameLabel.text = item.title
    }
}
