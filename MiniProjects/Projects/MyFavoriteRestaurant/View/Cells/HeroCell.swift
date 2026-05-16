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
        contentView.backgroundColor = .calculatorPink
        contentView.makeRounded(cornerRadius: 20)
    }
}
