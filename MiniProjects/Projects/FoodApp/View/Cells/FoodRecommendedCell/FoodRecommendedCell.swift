//
//  FoodRecommendedCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 28/5/2569 BE.
//

import UIKit

class FoodRecommendedCell: UICollectionViewCell {

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
extension FoodRecommendedCell {
    private func stlye() {
        containerView.makeRounded(cornerRadius: 20)
        containerView.addBorder()
        imageContainer.backgroundColor = .calculatorPurple
        nameLabel.font = .systemFont(ofSize: 18)
        priceLabel.font = .systemFont(ofSize: 16)
        priceLabel.textColor = .secondaryLabel
    }

    func configure(with item: FoodList) {
        image.image = UIImage(named: item.imageName)
        nameLabel.text = item.title
        priceLabel.text = "\(item.price) บาท"
    }
}
