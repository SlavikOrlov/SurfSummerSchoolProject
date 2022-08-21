//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 03.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Views

    @IBOutlet weak var logoutButtonLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Constants

    private let profileViewTableCell: String = "\(ProfileViewTableCell.self)"
    private let profileTitleTableViewCell: String = "\(ProfileTitleTableViewCell.self)"
    private let numberOfRows = 4
    private let tableCellHeight: CGFloat = 170
    private let titleTableCellHeight: CGFloat = 72
    
    // MARK: - Properties

    private var profileModel: ProfileModel = ProfileExample.shared.profileModel
    
    //MARK: - Lifecyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    // MARK: - Actions

    @IBAction func logoutButtonLabel(_ sender: Any) {
        addAlertView(for: self, text: "Вы точно хотите выйти из приложения?", completion: { action in
            LogoutService()
                .performLogoutRequestAndRemoveToken() { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                                let authorizationViewController = AuthorizationViewController()
                                let navigationAuthViewController = UINavigationController(rootViewController: authorizationViewController)
                                delegate.window?.rootViewController = navigationAuthViewController
                            }
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            var textForSnackbar = "Не удалось выйти, попробуйте еще раз"
                            if let currentError = error as? SomeErrors {
                                switch currentError {
                                case .notNetworkConnection:
                                    textForSnackbar = "Отсутствует интернет-соединение \nПопробуйте позже"
                                default:
                                    textForSnackbar = "Не удалось выйти, попробуйте еще раз"
                                }
                            }
                            
                            let model = SnackbarModel(text: textForSnackbar)
                            let snackbar = SnackbarView(model: model)
                            guard let `self` = self else { return }
                            snackbar.showSnackBar(on: self, with: model)
                        }
                    }
                }
        })
    }

    // MARK: - Private Methods

    private func configureNavigationBar() {
        navigationItem.title = "Профиль"
    }
    
    private func configureTableView() {
        tableView.register(
            UINib(
                nibName: profileViewTableCell,
                bundle: .main), forCellReuseIdentifier: profileViewTableCell)
        tableView.register(
            UINib(
                nibName: profileTitleTableViewCell,
                bundle: .main), forCellReuseIdentifier: profileTitleTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileViewTableCell)
            if let cell = cell as? ProfileViewTableCell {
                cell.imageUrlInString = profileModel.avatar
                cell.profileTextLabel.text = profileModel.about
                cell.profileFirstNameLabel.text = profileModel.firstName
                cell.profileSecondNameLabel.text = profileModel.secondName
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileTitleTableViewCell)
            if let cell = cell as? ProfileTitleTableViewCell {
                cell.profileTitleLable.text = "Город"
                cell.profileDetailLable.text = profileModel.city
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileTitleTableViewCell)
            if let cell = cell as? ProfileTitleTableViewCell {
                cell.profileTitleLable.text = "Телефон"
                cell.profileDetailLable.text = phoneMask(phoneNumber: profileModel.phone, shouldRemoveLastDigit: false)
            }
            return cell ?? UITableViewCell()
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileTitleTableViewCell)
            if let cell = cell as? ProfileTitleTableViewCell {
                cell.profileTitleLable.text = "Почта"
                cell.profileDetailLable.text = profileModel.email
            }
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return tableCellHeight
        default:
            return titleTableCellHeight
        }
    }
}
