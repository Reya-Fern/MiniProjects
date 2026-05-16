//
//  RecommendedCell.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 16/5/2569 BE.
//

import UIKit

final class RecommendedCell: UICollectionViewCell, FoodPricable {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
}

//MARK: - UI
extension RecommendedCell {
    private func style() {
        contentView.backgroundColor = .clear
        contentView.makeRounded(cornerRadius: 20)
        contentView.addBorder()
        imageContentView.backgroundColor = .calculatorPurple
    }
}
