//
//  SectionHeaderView.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 16/5/2569 BE.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }
}
