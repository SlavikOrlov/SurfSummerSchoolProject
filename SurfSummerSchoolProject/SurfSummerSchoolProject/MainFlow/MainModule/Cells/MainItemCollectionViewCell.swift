//
//  MainItemCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 06.08.2022.
//

import UIKit

class MainItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants
    
    private enum Constants {
        static let favoriteTapped = ImagesExtension.favoriteTapped
        static let favoriteUntapped = ImagesExtension.favoriteUntapped
    }
    let favoritesStorage = FavoritesStorage.shared
    
    // MARK: - Views
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Events
    
    var didFavoritesTapped: (() -> Void)?
    
    // MARK: - Calculated
    
    var buttonImage: UIImage? {
        return isFavorite ? Constants.favoriteTapped : Constants.favoriteUntapped
    }
    
    // анимацию в отдельный метод (разделить из-зи большого кол-ва ответственности
    // Нажатие кнопки и уменьшение
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.contentView.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
            }
        }
    }
    // MARK: - Properties
    
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                return
            }
            imageView.loadImage(from: url)
        }
    }
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func favoriteButton(_ sender: UIButton) {
        didFavoritesTapped?()
        if favoritesStorage.isPostFavorite(post: self.titleLabel.text ?? "") {
            favoritesStorage.removeFavorite(favoritePost: self.titleLabel.text ?? "")
        } else {
            favoritesStorage.addFavorite(favoritePost: self.titleLabel.text ?? "")
        }
        isFavorite.toggle()
    }
    
    // MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    override func prepareForReuse() {
        imageUrlInString = ""
        titleLabel.text = ""
        imageView.image = UIImage()
    }
}

// MARK: - Private Methods

private extension MainItemCollectionViewCell {
    
    func configureAppearance() {
        titleLabel.textColor = ColorsExtension.black
        titleLabel.font = .systemFont(ofSize: 12)
        imageView.layer.cornerRadius = 12
        favoriteButton.tintColor = ColorsExtension.white
        isFavorite = false
    }
}
