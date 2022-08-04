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

    }

}
