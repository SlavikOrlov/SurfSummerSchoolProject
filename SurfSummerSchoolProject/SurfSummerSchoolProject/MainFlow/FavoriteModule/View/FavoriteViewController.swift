//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    //MARK: - Views
    
    @IBOutlet weak var emptyFavoritesImage: UIImageView!
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    private let tableView = UITableView()
    private let postModel: MainModel = MainModel.shared
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Constants
    
    private enum ConstantImages {
        static let searchBar: UIImage? = ImagesExtension.searchBar
        static let sadSmile: UIImage? = ImagesExtension.sadSmile
    }
    
    private let detailImageTableViewCell: String = "\(DetailImageTableViewCell.self)"
    private let detailTitleTableViewCell: String = "\(DetailTitleTableViewCell.self)"
    private let detailTextTableViewCell: String = "\(DetailTextTableViewCell.self)"
    private let alertViewText: String = "Вы точно хотите удалить из избранного?"
    private let numberOfRows = 3
    
    // MARK: - Properties
    
    private let model: MainModel = MainModel.shared
    static var favoriteTapStatus: Bool = false
    static var successLoadingPostsAfterZeroScreen: Bool = false
    
    // MARK: - Lifecyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        if !(postModel.favoritePosts.isEmpty) && FavoriteViewController.successLoadingPostsAfterZeroScreen {
            notEmptyFavoritesNotification()
            tableView.reloadData()
            FavoriteViewController.successLoadingPostsAfterZeroScreen = false
        }
        if FavoriteViewController.favoriteTapStatus {
            tableView.reloadData()
            FavoriteViewController.favoriteTapStatus = false
            postModel.favoritePosts.isEmpty ? emptyFavoritesNotification() : notEmptyFavoritesNotification()
        }
    }
}

// MARK: - Private Methods

private extension FavoriteViewController {
    
    func configureAppearance() {
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Избранное"
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
        emptyFavoritesNotification()
        postModel.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                self.tableView.reloadData()
                self.postModel.favoritePosts.isEmpty ?
                self.emptyFavoritesNotification() : self.notEmptyFavoritesNotification()
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.register(
            UINib(
                nibName: detailImageTableViewCell,
                bundle: .main), forCellReuseIdentifier: detailImageTableViewCell)
        tableView.register(
            UINib(
                nibName: detailTitleTableViewCell,
                bundle: .main), forCellReuseIdentifier: detailTitleTableViewCell)
        tableView.register(
            UINib(
                nibName: detailTextTableViewCell,
                bundle: .main), forCellReuseIdentifier: detailTextTableViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func emptyFavoritesNotification() {
        refreshControl.removeFromSuperview()
        view.bringSubviewToFront(emptyFavoritesImage)
        view.bringSubviewToFront(emptyFavoritesLabel)
        emptyFavoritesImage.image = ConstantImages.sadSmile
        emptyFavoritesLabel.font = .systemFont(ofSize: 14, weight: .light)
        emptyFavoritesLabel.text = "В избранном пусто"
    }
    
    func notEmptyFavoritesNotification() {
        configurePullToRefresh()
        emptyFavoritesImage.image = UIImage()
        emptyFavoritesLabel.text = ""
    }
    
    func configurePullToRefresh() {
        refreshControl.addTarget(
            self,
            action: #selector(self.pullToRefresh(_:)),
            for: .valueChanged
        )
        refreshControl.tintColor = ColorsExtension.lightGray
        refreshControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        tableView.addSubview(refreshControl)
    }
    
    // MARK: - Actions
    
    @objc func enterSearchViewController(sender: UIBarButtonItem) {
        let searchViewController = SearchViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    @objc func pullToRefresh(_ sender: AnyObject) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postModel.favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailImageTableViewCell)
            if let cell = cell as? DetailImageTableViewCell {
                let currentPost = postModel.favoritePosts[indexPath.section]
                cell.imageUrlInString = currentPost.imageUrlInString
                cell.isFavorite = currentPost.isFavorite
                cell.postTextLabel = currentPost.title
                cell.didFavoriteTap = { [weak self] in
                    guard let `self` = self else { return }
                    addAlertView(for: self, text: self.alertViewText) { action in
                        let favoritesStorage: FavoritesStorage = FavoritesStorage.shared
                        
                        if favoritesStorage.isPostFavorite(post: currentPost.title) {
                            favoritesStorage.removeFavorite(favoritePost: currentPost.title)
                        } else {
                            favoritesStorage.addFavorite(favoritePost: currentPost.title)
                        }
                        cell.isFavorite.toggle()
                        let favoritePost = self.postModel.favoritePosts[indexPath.section]
                        self.postModel.favoritePost(for: favoritePost)
                        self.tableView.reloadData()
                        self.postModel.favoritePosts.isEmpty ? self.emptyFavoritesNotification() : self.notEmptyFavoritesNotification()
                    }
                }
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailTitleTableViewCell)
            if let cell = cell as? DetailTitleTableViewCell {
                cell.cartTitleLabel.text =
                postModel.favoritePosts[indexPath.section].title
                cell.dateLabel.text =
                postModel.favoritePosts[indexPath.section].dateCreation
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailTextTableViewCell)
            if let cell = cell as? DetailTextTableViewCell {
                cell.contentLabel.text = postModel.favoritePosts[indexPath.section].content
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.model = self.postModel.favoritePosts[indexPath.section]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
