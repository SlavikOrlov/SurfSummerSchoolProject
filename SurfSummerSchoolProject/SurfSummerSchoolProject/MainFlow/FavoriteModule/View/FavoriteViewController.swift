//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum ConstantImages {
        static let searchBar: UIImage? = ImagesExtension.searchBar
    }
    
    // MARK: - Views
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let model = FavoriteModel.init()
    
    // MARK: - Lifecyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        model.getPosts()
    }
    
    // MARK: - Actions
    
    @objc func searchBarButtonTap() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

// MARK: - Private Methods

private extension FavoriteViewController {
    
    func configureAppearance() {
        configuresearchButton()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "\(FavoriteViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(FavoriteViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func configuresearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: ConstantImages.searchBar,
            style: .plain,
            target: self,
            action: #selector(searchBarButtonTap))
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteViewCell.self)")
        let item = model.items[indexPath.row]
        if let cell = cell as? FavoriteViewCell {
            cell.image = item.image
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.date = item.dateCreation
            cell.content = item.content
        }
        return cell ?? UITableViewCell()
    }
}
