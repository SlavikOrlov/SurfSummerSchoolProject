//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchTab"), style: .plain, target: self, action: #selector(searchBarButtonTap))
    }
    
    @objc func searchBarButtonTap() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    
    
}
