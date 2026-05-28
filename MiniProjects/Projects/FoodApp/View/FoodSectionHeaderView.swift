//
//  SectionHeaderVie.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 28/5/2569 BE.
//

import UIKit

final class FoodSectionHeaderView: UICollectionReusableView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        stlye()
    }

    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - UI
extension FoodSectionHeaderView {

    private func stlye() {

        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}
