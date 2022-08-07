//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 04.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Views
    
    private lazy var searchBar = UISearchBar()

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
}
    
// MARK: - Privat Methods

private extension SearchViewController {
        
        func configureAppearance() {
            searchBar = UISearchBar(frame: CGRect(x: 56, y: 53, width: 303, height: 32))
            searchBar.searchBarStyle = .minimal
            searchBar.placeholder = "Поиск"
            searchBar.layer.cornerRadius = 22
            searchBar.clipsToBounds = true
            view.addSubview(searchBar)
        }
        
        func configureNavigationBar() {
            let backButton = UIBarButtonItem(image: UIImage(named: "back-button"),
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(UINavigationController.popViewController(animated:)))
            navigationItem.leftBarButtonItem = backButton
            navigationItem.leftBarButtonItem?.tintColor = .black
            navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }

