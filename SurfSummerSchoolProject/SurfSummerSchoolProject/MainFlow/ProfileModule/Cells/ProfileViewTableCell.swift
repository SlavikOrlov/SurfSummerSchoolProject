//
//  ProfileViewTableCell.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 19.08.2022.
//

import UIKit

class ProfileViewTableCell: UITableViewCell {

    // MARK: - Views

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileFirstNameLabel: UILabel!
    @IBOutlet weak var profileSecondNameLabel: UILabel!
    @IBOutlet weak var profileTextLabel: UILabel!
    
    //MARK: - Properties
    
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                 return
             }
            profileImageView.loadImage(from: url)
        }
    }
    
    //MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        profileImageView.layer.cornerRadius = 12
    }
}
