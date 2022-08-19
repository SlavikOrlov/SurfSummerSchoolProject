//
//  FavoriteViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 07.08.2022.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let favoriteTapped = ImagesExtension.favoriteTapped
        static let favoriteUntapped = ImagesExtension.favoriteUntapped
    }
    // MARK: - Views
    
    @IBOutlet private weak var favoriteImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var favoriteTitle: UILabel!
    @IBOutlet private weak var favoriteDate: UILabel!
    @IBOutlet private weak var favoriteContent: UILabel!
    
    // MARK: - Properties
    
    var image: UIImage? {
        didSet {
            favoriteImage.image = image
        }
    }
    
    var isFavorite: Bool = false {
        didSet {
            let image = isFavorite ? Constants.favoriteTapped : Constants.favoriteUntapped
            favoriteButton.setImage(image , for: .normal)
        }
    }
    
    var title: String = "" {
        didSet {
            favoriteTitle.text = title
        }
    }
    
    var date: String = "" {
        didSet {
            favoriteDate.text = date
        }
    }
    
    var content: String = "" {
        didSet {
            favoriteContent.text = content
        }
    }
    
    // MARK: - Actions
    
    @IBAction func heartButtonAction(_ sender: Any) {
        if isFavorite == false {
            isFavorite = true
        } else {
            isFavorite = false
        }
    }
    
    // MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: - Private Methods

private extension FavoriteViewCell {
    
    func configureAppearance() {
        selectionStyle = .none
        
        favoriteImage.layer.cornerRadius = 12
        favoriteImage.contentMode = .scaleAspectFill
        
        favoriteTitle.font = .systemFont(ofSize: 16, weight: .medium)
        
        favoriteDate.font = .systemFont(ofSize: 10, weight: .medium)
        favoriteDate.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
        
        favoriteContent.font = .systemFont(ofSize: 12, weight: .light)
        favoriteContent.numberOfLines = 1
    }
}

