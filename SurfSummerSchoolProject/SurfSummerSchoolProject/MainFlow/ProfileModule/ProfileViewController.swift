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
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func logoutButtonLabel(_ sender: Any) {
    }
}
