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

        view.backgroundColor = .systemGray5
        collectionView.backgroundColor = .clear
        
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

            let section = Section.allCases[indexPath.section]

            switch section {
            case .hero:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell",for: indexPath) as! HeroCell
                cell.configure(with: item)
                return cell

            case .categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell",for: indexPath) as! CategoryCell
                cell.configure(with: item)
                return cell

            case .recommended:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCell",for: indexPath) as! RecommendedCell
                cell.configure(with: item)
                return cell

            case .all:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllCell",for: indexPath) as! AllCell
                cell.configure(with: item)
                return cell
            }
        }
    }

    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FoodItem>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(heroItems, toSection: .hero)
        snapshot.appendItems(categoryItems, toSection: .categories)
        snapshot.appendItems(recommendedItems, toSection: .recommended)
        snapshot.appendItems(allItems, toSection: .all)

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
            case .recommended:
                return self.createRecommendedSection()
            case .all:
                return self.createAllSection()
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

    func createRecommendedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: 8,leading: 8,bottom: 8,trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(180),
            heightDimension: .absolute(240)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    func createAllSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: 8,leading: 8,bottom: 8,trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(120)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 2
        )

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}
