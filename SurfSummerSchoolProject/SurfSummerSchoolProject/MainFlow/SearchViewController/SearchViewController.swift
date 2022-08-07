//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 04.08.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Поиск"
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        

    }

}
