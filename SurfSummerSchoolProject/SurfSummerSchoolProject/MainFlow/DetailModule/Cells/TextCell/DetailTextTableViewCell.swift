//
//  DetailTextTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 07.08.2022.
//

import UIKit

final class DetailTextTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

}

// MARK: - Private Methods

private extension DetailTextTableViewCell {

    func configureAppearance() {
        selectionStyle = .none
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        contentLabel.textColor = ColorsExtension.black
        contentLabel.numberOfLines = 0
    }

}
