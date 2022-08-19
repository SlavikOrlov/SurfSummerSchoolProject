//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Constants
    private enum ConstantImages {
        static let searchBar: UIImage? = ImagesExtension.searchBar
    }
    
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }
    
    // MARK: - Properties
    
    private let model: MainModel = .init()
    
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Lifecyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuresearchButton()
        configureApperance()
        configureModel()
        model.loadPosts()
    }
}

// MARK: - Private Methods

private extension MainViewController {

    func configureApperance() {
        navigationItem.title = "Главная"
        collectionView.register(
            UINib(
                nibName: "\(MainItemCollectionViewCell.self)",
                bundle: .main),
                forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(
            top: 10,
            left: 16,
            bottom: 10,
            right: 16
        )
    }

    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.collectionView.reloadData()
            }
        }
    }
    // My version searchButtonTap
    func configuresearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: ConstantImages.searchBar,
            style: .plain,
            target: self,
            action: #selector(searchBarButtonTap))
    }
}
    
    
    

// MARK: - UICollection

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.imageUrlInString = item.imageUrlInString
            cell.didFavoritesTapped = { [weak self] in
                self?.model.items[indexPath.row].isFavorite.toggle()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horizontalInset * 2 - Constants.spaceBetweenElements) / 2
        return CGSize(width: itemWidth, height: 1.46 * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.model = model.items[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc func searchBarButtonTap() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}
