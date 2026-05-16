//
//  MyFavoriteRestaurant.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 15/5/2569 BE.
//

import UIKit

final class MyFavoritePlaceViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<Section, FoodItem>!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDataSource()
        applySnapshot()
    }
}

// MARK: - UI
extension MyFavoritePlaceViewController {
    private func configureUI() {
        view.backgroundColor = .systemGray5
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = FoodLayoutBuilder.createLayout()
    }
}

// MARK: - Collection View
extension MyFavoritePlaceViewController {
    // Data Source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView)
        { collectionView, indexPath, item in

            let section = self.section(at: indexPath)

            switch section {
            case .hero:
                let cell: HeroCell = collectionView.dequeueCell(for: indexPath)
                cell.configureFood(with: item)
                return cell

            case .categories:
                let cell: CategoryCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(with: item)
                return cell

            case .recommended:
                let cell: RecommendedCell = collectionView.dequeueCell(for: indexPath)
                cell.configureFood(with: item)
                return cell

            case .all:
                let cell: AllCell = collectionView.dequeueCell(for: indexPath)
                cell.configureFood(with: item)
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }

            let header: SectionHeaderView = collectionView.dequeueSupplementaryView(ofKind: kind, for: indexPath)

            let section = self.section(at: indexPath)
            header.titleLabel.text = section.title

            return header
        }
    }

    // Snapshot
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FoodItem>()

        snapshot.appendSections(Section.allCases)

        Section.allCases.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // Helper
    private func section(at indexPath: IndexPath) -> Section {
        Section.allCases[indexPath.section]
    }
}
