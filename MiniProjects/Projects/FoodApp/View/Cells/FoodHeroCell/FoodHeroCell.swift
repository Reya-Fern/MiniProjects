//
//  FoodHeroCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 20/5/2569 BE.
//

import UIKit

final class FoodHeroCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
}

//MARK: - UI
extension FoodHeroCell {
    private func style() {
        containerView.backgroundColor = .calculatorPink
        containerView.makeRounded(cornerRadius: 20)
    }

    func configure(with item: FoodList) {
        nameLabel.text = item.title
        priceLabel.text = "\(item.price) บาท"
        foodImage.image = UIImage(named: item.imageName)
    }
}
