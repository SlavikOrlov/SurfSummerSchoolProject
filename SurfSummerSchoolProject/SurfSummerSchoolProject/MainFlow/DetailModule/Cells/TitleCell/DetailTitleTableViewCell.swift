//
//  DetailTitleTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 07.08.2022.
//

import UIKit

final class DetailTitleTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var cartTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        cartTitleLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = ColorsExtension.black
    }
}
