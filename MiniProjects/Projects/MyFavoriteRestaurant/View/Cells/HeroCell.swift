//
//  FoodCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 15/5/2569 BE.
//

import UIKit

final class HeroCell: UICollectionViewCell, FoodPricable {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
}

//MARK: - UI
extension HeroCell {
    private func style() {
        contentView.backgroundColor = .secoundPink
        contentView.makeRounded(cornerRadius: 20)
        nameLabel.font = .systemFont(ofSize: 18)
        priceLabel.font = .systemFont(ofSize: 16)
        priceLabel.textColor = .secondaryLabel
    }
}
