//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 07.08.2022.
//

import UIKit

final class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Constants
    private let backArrowImage: UIImage? = ImagesExtension.backArrow
    private let detailImageTableViewCell: String = "\(DetailImageTableViewCell.self)"
    private let detailTitleTableViewCell: String = "\(DetailTitleTableViewCell.self)"
    private let detailTextTableViewCell: String = "\(DetailTextTableViewCell.self)"
    private let numberOfRows = 3

    // MARK: - Views
    
    private let tableView = UITableView()
    
    // MARK: - Properties
    
    var model: DetailItemModel?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
}

// MARK: - Privat Methods

private extension DetailViewController {
    
    func configureAppearance() {
        configureNavigationBar()
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = model?.title
        let backButton = UIBarButtonItem(image: backArrowImage,
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.interactivePopGestureRecognizer?.delegate = self
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
        // вынести в extension!!!
        tableView.register(UINib(nibName: detailImageTableViewCell, bundle: .main), forCellReuseIdentifier: detailImageTableViewCell)
        tableView.register(UINib(nibName: detailTitleTableViewCell, bundle: .main), forCellReuseIdentifier: detailTitleTableViewCell)
        tableView.register(UINib(nibName: detailTextTableViewCell, bundle: .main), forCellReuseIdentifier: detailTextTableViewCell)
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailImageTableViewCell)
            if let cell = cell as? DetailImageTableViewCell {
                cell.imageUrlInString = model?.imageUrlInString ?? ""
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailTitleTableViewCell)
            if let cell = cell as? DetailTitleTableViewCell {
                cell.title = model?.title ?? ""
                cell.date = model?.dateCreation ?? ""
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailTextTableViewCell)
            if let cell = cell as? DetailTextTableViewCell {
                cell.text = model?.content
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
