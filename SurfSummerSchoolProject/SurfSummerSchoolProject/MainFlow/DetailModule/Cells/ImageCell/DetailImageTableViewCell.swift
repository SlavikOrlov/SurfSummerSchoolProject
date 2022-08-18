//
//  DetailImageTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 07.08.2022.
//

import UIKit

final class DetailImageTableViewCell: UITableViewCell {
    
    //MARK: - Constants
    private enum Constants {
        static let favoriteTapped = UIImage(named: "favoriteTapped")
        static let favoriteUntapped = UIImage(named: "favoriteUntapped")
    }
    
    // MARK: - Views
    
    @IBOutlet private weak var cartImageView: UIImageView!
    @IBOutlet weak var favoriteButtonLabel: UIButton!
    
    // MARK: - Events

    @IBAction func favoriteButtonAction(_ sender: Any) {
    }
    
    // MARK: - Calculated
    var buttonImage: UIImage? {
        return isFavorite ? Constants.favoriteTapped : Constants.favoriteUntapped
    }
    
    // MARK: - Properties
    
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                return
            }
            cartImageView?.loadImage(from: url)
        }
    }
    
    var isFavorite = false {
        didSet {
            favoriteButtonLabel.setImage(buttonImage, for: .normal)
        }
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }
}
