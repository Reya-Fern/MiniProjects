//
//  UIViewExtension.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 17/5/2569 BE.
//

import UIKit

extension UIView {

    func makeRounded(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }

    func addBorder(width: CGFloat = 1,color: UIColor = .systemGray4) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    //Identifier
    static var reuseIdentifier: String {
        String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
