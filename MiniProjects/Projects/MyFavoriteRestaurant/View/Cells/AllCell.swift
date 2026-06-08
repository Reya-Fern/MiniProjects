//
//  allCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 16/5/2569 BE.
//

import UIKit

final class AllCell: UICollectionViewCell, FoodPricable {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
}

//MARK: - UI
extension AllCell {
    private func style() {
        contentView.backgroundColor = .clear
        contentView.makeRounded(cornerRadius: 20)
        contentView.addBorder()
        imageContainer.backgroundColor = .calculatorGreen
        imageContainer.makeRounded(cornerRadius: 20)
        nameLabel.font = .systemFont(ofSize: 18)
        priceLabel.font = .systemFont(ofSize: 16)
        priceLabel.textColor = .secondaryLabel
    }
}
