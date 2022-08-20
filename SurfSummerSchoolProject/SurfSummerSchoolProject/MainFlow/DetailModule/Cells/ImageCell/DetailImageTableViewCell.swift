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
        static let favoriteTapped = ImagesExtension.favoriteTapped
        static let favoriteUntapped = ImagesExtension.favoriteUntapped
    }
    let favoritesStorage = FavoritesStorage.shared
    var postTextLabel: String = ""
    
    // MARK: - Views
    
    @IBOutlet private weak var cartImageView: UIImageView!
    @IBOutlet private weak var favoriteButtonLabel: UIButton!
    
    // MARK: - Events

    var didFavoriteTap: (() -> Void)?
    @IBAction func favoriteButtonAction(_ sender: Any) {
        didFavoriteTap?()
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
    
    override func prepareForReuse() {
        cartImageView.image = UIImage()
    }
}
