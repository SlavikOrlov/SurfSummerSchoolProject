//
//  DetailTextTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 07.08.2022.
//

import UIKit

final class DetailTextTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    private func configureAppearance() {
        selectionStyle = .none
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.textColor = ColorsExtension.black
        contentLabel.numberOfLines = 0
    }
}
