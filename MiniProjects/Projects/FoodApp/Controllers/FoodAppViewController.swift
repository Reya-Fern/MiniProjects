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
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UINib(nibName: "FoodHeroCell", bundle: nil), forCellWithReuseIdentifier: "FoodHeroCell")
    }
}

// MARK: - Collection View
extension FoodAppViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.heroItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodHeroCell", for: indexPath) as! FoodHeroCell
        guard let item = data?.heroItems[indexPath.item] else {
            return cell
        }

        cell.configure(with: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
}
