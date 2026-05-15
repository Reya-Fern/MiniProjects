//
//  MyFavoriteRestaurant.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 15/5/2569 BE.
//

import UIKit

class MyFavoritePlaceViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section, FoodItem>!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        applySnapshot()
    }
}

//MARK: - Methods
extension MyFavoritePlaceViewController {

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView)
        { collectionView, indexPath, item in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            cell.configure(with: item)

            return cell
        }
    }

    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FoodItem>()
        snapshot.appendSections([.hero])
        snapshot.appendItems(heroItems)

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 220)
        layout.scrollDirection = .vertical

        return layout
    }
}
