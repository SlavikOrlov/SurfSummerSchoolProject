//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 04.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Views
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
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
            searchBar.placeholder = "Поиск"
            searchBar.searchTextField.font = .systemFont(ofSize: 14)
            searchBar.layer.borderWidth = 1
            searchBar.layer.borderColor = UIColor.white.cgColor
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

