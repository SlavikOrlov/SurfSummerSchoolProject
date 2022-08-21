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
    static var favoriteTapStatus: Bool = false
    private let mainItemCollectionViewCell: String = "\(MainItemCollectionViewCell.self)"
    private let cellProportion: Double = 245/168
    private let getPostErrorViewController = LoadErrorViewController()
    
    
    // MARK: - Properties
    
    private let model = MainModel.shared
    
    // MARK: - Views
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        configureModel()
        model.loadPosts()
        configurePullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MainViewController.favoriteTapStatus {
            collectionView.reloadData()
            MainViewController.favoriteTapStatus = false
        }
        appendStateViewController {
            self.model.loadPosts()
            self.getPostErrorViewController.view.alpha = 0
            self.activityIndicatorView.isHidden = false
        }
        if model.currentState == .error && model.posts.isEmpty {
            getPostErrorViewController.view.alpha = 1
            configureModel()
        }
        configureNavigationBar()
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func configureApperance() {
        collectionView.register(
            UINib(
                nibName: mainItemCollectionViewCell,
                bundle: .main),
            forCellWithReuseIdentifier: mainItemCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(
            top: 10,
            left: 16,
            bottom: 10,
            right: 16
        )
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
        let searchButton = UIBarButtonItem(
            image: ConstantImages.searchBar,
            style: .plain,
            target: self,
            action: #selector(enterSearchViewController(sender:))
        )
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.rightBarButtonItem?.tintColor = ColorsExtension.black
    }
    
    func configureModel() {
        model.didItemsError = { [weak self] in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                if self.model.posts.isEmpty {
                    self.activityIndicatorView.isHidden = true
                    self.getPostErrorViewController.view.alpha = 1
                } else {
                    let textForSnackBar = MainModel.errorMassege
                    let model = SnackbarModel(text: textForSnackBar)
                    let snackbar = SnackbarView(model: model)
                    snackbar.showSnackBar(on: self, with: model)
                }
            }
        }
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicatorView.isHidden = true
                self?.collectionView.reloadData()
                FavoriteViewController.successLoadingPostsAfterZeroScreen = true
            }
        }
    }
    
    func configurePullToRefresh() {
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = ColorsExtension.lightGray
        refreshControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        collectionView.addSubview(refreshControl)
    }
    
    func appendStateViewController(reloadButtonAction: @escaping ()->Void) {
        getPostErrorViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(getPostErrorViewController)
        self.view.addSubview(getPostErrorViewController.view)
        getPostErrorViewController.didMove(toParent: self)
        
        getPostErrorViewController.view.topAnchor.constraint(
            equalTo: self.view.topAnchor).isActive = true
        getPostErrorViewController.view.leadingAnchor.constraint(
            equalTo: self.view.leadingAnchor).isActive = true
        getPostErrorViewController.view.trailingAnchor.constraint(
            equalTo: self.view.trailingAnchor).isActive = true
        getPostErrorViewController.view.bottomAnchor.constraint(
            equalTo: self.view.bottomAnchor).isActive = true
        getPostErrorViewController.view.alpha = 0
        getPostErrorViewController.reloadButtonAction = reloadButtonAction
    }
    
    // MARK: - Actions
    
    @objc func enterSearchViewController(sender: UIBarButtonItem) {
        let searchViewController = SearchViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    @objc func pullToRefresh(_ sender: AnyObject) {
        self.model.loadPosts()
        refreshControl.endRefreshing()
    }
}

// MARK: - UICollection

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainItemCollectionViewCell, for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            self.activityIndicatorView.isHidden = true
            cell.titleLabel.text = model.posts[indexPath.item].title
            cell.isFavorite = model.posts[indexPath.item].isFavorite
            cell.imageUrlInString = model.posts[indexPath.item].imageUrlInString
            cell.didFavoritesTapped = { [weak self] in
                self?.model.posts[indexPath.row].isFavorite.toggle()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horizontalInset * 2 - Constants.spaceBetweenElements) / 2
        return CGSize(width: itemWidth, height: cellProportion * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.model = model.posts[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
