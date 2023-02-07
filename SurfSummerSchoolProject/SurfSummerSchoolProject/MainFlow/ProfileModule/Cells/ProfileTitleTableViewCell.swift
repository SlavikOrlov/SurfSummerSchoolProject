//
//  ProfileTitleTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 19.08.2022.
//

import UIKit

final class ProfileTitleTableViewCell: UITableViewCell {

    // MARK: - Actions

    @IBOutlet weak var profileTitleLable: UILabel!
    @IBOutlet weak var profileDetailLable: UILabel!
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
