//
//  FoodAllCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 28/5/2569 BE.
//

import UIKit

final class FoodAllCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        stlye()
    }
}

// MARK: - UI
extension FoodAllCell {
    private func stlye() {
        containerView.makeRounded(cornerRadius: 20)
        containerView.addBorder()
        imageContainer.backgroundColor = .calculatorGreen
        imageContainer.makeRounded(cornerRadius: 20)
    }

    func configure(with item: FoodList) {
        image.image = UIImage(named: item.imageName)
        nameLabel.text = item.title
        priceLabel.text = "\(item.price) บาท"
    }
}
