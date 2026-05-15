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
        {collectionView, indexPath, item in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
            cell.configure(with: item)

            return cell
        }
    }

    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FoodItem>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(heroItems, toSection: .hero)
        snapshot.appendItems(categoryItems, toSection: .categories)

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {sectionIndex, environment in

            let section = Section.allCases[sectionIndex]

            switch section {
            case .hero:
                return self.createHeroSection()
            case .categories:
                return self.createCategorySection()
            }
        }
    }

    func createHeroSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(220)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(120)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}
