//
//  FoodAppViewController.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 20/5/2569 BE.
//

import UIKit

final class FoodAppViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    let data = MockFoodService.shared.fetchFoodData()

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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)

        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self

        registerCells()
    }

    private func registerCells() {
        collectionView.register(UINib(nibName: "FoodHeroCell", bundle: nil), forCellWithReuseIdentifier: "FoodHeroCell")
        collectionView.register(UINib(nibName: "FoodCategoryCell", bundle: nil), forCellWithReuseIdentifier: "FoodCategoryCell")
        collectionView.register(UINib(nibName: "FoodRecommendedCell", bundle: nil), forCellWithReuseIdentifier: "FoodRecommendedCell")
    }
}

// MARK: - Collection View
extension FoodAppViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return FoodSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data else { return 0 }

        let currentSection = FoodSection(rawValue: section)

        switch currentSection {
        case .hero:
            return data.heroItems.count
        case .categories:
            return data.categoryItems.count
        case .recommended:
            return data.recommendedItems.count
            //        case .all:
            //            return data.allItems.count
        case .none:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data else { return UICollectionViewCell() }

        let section = FoodSection(rawValue: indexPath.section)

        switch section {
        case .hero:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodHeroCell", for: indexPath) as! FoodHeroCell
            let item = data.heroItems[indexPath.row]

            cell.configure(with: item)

            return cell

        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCell", for: indexPath) as! FoodCategoryCell
            let item = data.categoryItems[indexPath.row]

            cell.configure(with: item)

            return cell

        case .recommended:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodRecommendedCell", for: indexPath) as! FoodRecommendedCell
            let item = data.recommendedItems[indexPath.row]

            cell.configure(with: item)

            return cell

        case .none:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = FoodSection(rawValue: indexPath.section)

        switch section {
        case .hero:
            return CGSize(width: 300, height: 150)
        case .categories:
            return CGSize(width: 80, height: 100)
        case .recommended:
            return CGSize(width: 115, height: 165)
        case .none:
            return .zero
        }
    }
}
