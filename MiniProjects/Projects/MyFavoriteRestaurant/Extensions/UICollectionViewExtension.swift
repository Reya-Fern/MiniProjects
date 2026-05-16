//
//  UICollectionViewExtension.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 16/5/2569 BE.
//
import UIKit

extension UICollectionView {

    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: String(describing: T.self),for: indexPath) as! T
    }

    func dequeueSupplementaryView<T: UICollectionReusableView>(ofKind kind: String,for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: String(describing: T.self),for: indexPath) as! T
    }
}
