//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 04.08.2022.
//

import UIKit

final class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Constants
    
    private enum ConstantImages {
        static let backArrow: UIImage? = ImagesExtension.backArrow
        static let searchEye: UIImage? = ImagesExtension.searchEye
        static let sadSmile: UIImage? = ImagesExtension.sadSmile
    }
    
    private let mainItemCollectionViewCell: String = "\(MainItemCollectionViewCell.self)"
    private let cellProportion: Double = 245 / 168
    
    private enum ConstantConstraints {
        static let collectionViewPadding: CGFloat = 16
        static let hSpaceBetweenItems: CGFloat = 7
        static let vSpaceBetweenItems: CGFloat = 8
    }

    // MARK: - IBOutlets

    @IBOutlet weak var searchUserImage: UIImageView!
    @IBOutlet weak var searchUserLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    private var posts = MainModel.shared.filteredPosts(searchText: "")
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }

}

// MARK: - Privat Methods

private extension SearchViewController {
    
    func configureAppearance() {
        searchBar = UISearchBar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 303,
                height: 32
            )
        )
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 22
        
        searchUserImage.image = ConstantImages.searchEye
        searchUserLabel.font = .systemFont(
            ofSize: 14,
            weight: .light
        )
        searchUserLabel.text = "Введите ваш запрос"
        
        collectionView.contentInset = .init(
            top: 10,
            left: 16,
            bottom: 10,
            right: 16
        )
        collectionView.register(UINib(
            nibName: mainItemCollectionViewCell,
            bundle: .main), forCellWithReuseIdentifier: mainItemCollectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureNavigationBar() {
        let backButton = UIBarButtonItem(
            image: ConstantImages.backArrow,
            style: .plain,
            target: navigationController,
            action: #selector(UINavigationController.popViewController(animated:)
                                 )
        )
        let searchBarItem = UIBarButtonItem(customView: searchBar)
        navigationItem.rightBarButtonItem = searchBarItem
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = ColorsExtension.black
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searhText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        if !searhText.isEmpty {
            posts = MainModel.shared.filteredPosts(searchText: searchBar.text ?? "")
            searchUserImage.image = UIImage()
            searchUserLabel.text = ""
            if posts.isEmpty {
                searchUserImage.image = ConstantImages.sadSmile
                searchUserLabel.text = "По этому запросу нет результатов, попробуйте другой запрос"
                collectionView.reloadData()
            } else {
                collectionView.reloadData()
            }
        } else {
            posts = []
            collectionView.reloadData()
            searchUserImage.image = ConstantImages.searchEye
            searchUserLabel.text = "Введите ваш запрос"
        }
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return posts.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainItemCollectionViewCell, for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            cell.imageUrlInString = posts[indexPath.item].imageUrlInString
            cell.isFavorite = posts[indexPath.item].isFavorite
            cell.titleLabel.text = posts[indexPath.item].title
            cell.didFavoritesTapped = { [weak self] in
                self?.posts[indexPath.item].isFavorite.toggle()
                guard let post = self?.posts[indexPath.item] else { return }
                MainModel.shared.favoritePost(for: post)
            }
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemWidth = (view.frame.width -
                         ConstantConstraints.collectionViewPadding * 2 -
                         ConstantConstraints.hSpaceBetweenItems) / 2
        return CGSize(width: itemWidth, height: itemWidth * cellProportion)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return ConstantConstraints.vSpaceBetweenItems
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let detailViewController = DetailViewController()
        detailViewController.model = posts[indexPath.item]
        navigationController?.pushViewController(
            detailViewController,
            animated: true
        )
    }

}
