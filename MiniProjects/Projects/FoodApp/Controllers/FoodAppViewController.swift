//
//  FoodAppViewController.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 20/5/2569 BE.
//

import UIKit

final class FoodAppViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    private enum Layout {
        static let horizontalInset: CGFloat = 32
        static let standardSpacing: CGFloat = 16
        static let smallSpacing: CGFloat = 8
    }

    private let data = MockFoodService.shared.fetchFoodData()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setupCollectionView()
    }
}

// MARK: - UI
extension FoodAppViewController {

    private func configureUI() {
        view.backgroundColor = .systemGray5
        collectionView.backgroundColor = .clear
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.dataSource = self
        collectionView.delegate = self

        registerCells()
    }
}

// MARK: - Collection View
extension FoodAppViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return FoodSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currentSection = FoodSection(rawValue: section) else { return 0 }

        return items(for: currentSection)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = FoodSection(rawValue: indexPath.section) else { return UICollectionViewCell() }

        switch section {
        case .hero:
            return makeHeroCell(for: indexPath)
        case .categories:
            return makeCategoryCell(for: indexPath)
        case .recommended:
            return makeRecommendedCell(for: indexPath)
        case .all:
            return makeAllCell(for: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = FoodSection(rawValue: indexPath.section) else { return .zero }

        switch section {
        case .hero:
            let width = collectionView.bounds.width - Layout.horizontalInset
            let height = width * 0.45

            return CGSize(width: width, height: height)
        case .categories:
            let columns: CGFloat = collectionView.bounds.width > 500 ? 5 : 4

            let width = (collectionView.bounds.width - Layout.horizontalInset - ((columns - 1) * Layout.standardSpacing)) / columns
            return CGSize(width: width, height: width + 30)
        case .recommended:
            let columns: CGFloat = 2

            let width = (collectionView.bounds.width - Layout.horizontalInset - Layout.standardSpacing) / columns
            return CGSize(width: width, height: width * 1.1)
        case .all:
            let width = (collectionView.bounds.width - Layout.horizontalInset - Layout.smallSpacing) / 2
            return CGSize(width: width, height: 90)
        }
    }

    //Section Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FoodSectionHeaderView.reuseIdentifier, for: indexPath) as! FoodSectionHeaderView

        guard let section = FoodSection(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }

        header.configure(title: section.title)

        return header
    }
}

// MARK: - Helper
extension FoodAppViewController {
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.headerReferenceSize = CGSize(width: collectionView.bounds.width, height: 40)

        return layout
    }

    private func registerCells() {
        //Header
        collectionView.register(FoodSectionHeaderView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FoodSectionHeaderView.reuseIdentifier)
        //Section Item
        collectionView.register(FoodHeroCell.nib, forCellWithReuseIdentifier: FoodHeroCell.reuseIdentifier)
        collectionView.register(FoodCategoryCell.nib, forCellWithReuseIdentifier: FoodCategoryCell.reuseIdentifier)
        collectionView.register(FoodRecommendedCell.nib, forCellWithReuseIdentifier: FoodRecommendedCell.reuseIdentifier)
        collectionView.register(FoodAllCell.nib, forCellWithReuseIdentifier: FoodAllCell.reuseIdentifier)
    }

    private func items(for section: FoodSection) -> Int {
        guard let data else { return 0 }

        switch section {
        case .hero:
            return data.heroItems.count
        case .categories:
            return data.categoryItems.count
        case .recommended:
            return data.recommendedItems.count
        case .all:
            return data.allItems.count
        }
    }
}

// MARK: - Cell
extension FoodAppViewController {

    private func makeHeroCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let data else { return UICollectionViewCell() }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodHeroCell.reuseIdentifier, for: indexPath) as! FoodHeroCell

        let item = data.heroItems[indexPath.row]
        cell.configure(with: item)

        return cell
    }

    private func makeCategoryCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let data else { return UICollectionViewCell() }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCell.reuseIdentifier, for: indexPath) as! FoodCategoryCell

        let item = data.categoryItems[indexPath.row]
        cell.configure(with: item)

        return cell
    }

    private func makeRecommendedCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let data else { return UICollectionViewCell() }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodRecommendedCell.reuseIdentifier, for: indexPath) as! FoodRecommendedCell

        let item = data.recommendedItems[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }

    private func makeAllCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let data else { return UICollectionViewCell() }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodAllCell.reuseIdentifier, for: indexPath) as! FoodAllCell

        let item = data.allItems[indexPath.row]
        cell.configure(with: item)

        return cell
    }
}
