//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: Views

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let model = FavoriteModel.init()

    // MARK: - Lifecyrcle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
    }
    
    // MARK: Actions
    
    @objc func searchBarButtonTap() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

// MARK: - Private Methods

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteViewCell {
            let item = model.items[indexPath.row]
            cell.image = item.image
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.image = item.image
        }
        return cell
    }
    
    func configureAppearance() {
        configuresearchButton()
    }

    func configuresearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchTab"), style: .plain, target: self, action: #selector(searchBarButtonTap))
    }
}
