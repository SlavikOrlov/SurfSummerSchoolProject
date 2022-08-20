//
//  MainModel.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 06.08.2022.
//

import Foundation
import UIKit

final class MainModel {
    static let shared = MainModel.init()
    static var errorMassege: String = "xnj-nj"
    
    enum LoadState {
        case id
        case success
        case error
    }
    
    var currentState: LoadState = .id
    
    // MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    var didItemsError: (()->Void)?

    // MARK: - Properties
    
    let pictureService = PicturesService()
    let favoritesStorage = FavoritesStorage.shared
    var posts: [DetailModel] = []
    var favoritePosts: [DetailModel] {
        posts.filter { $0.isFavorite }
    }
    
    // MARK: - Methods
    
    func filteredPosts(searchText: String) -> [DetailModel] {
        posts.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    func loadPosts() {
        pictureService.loadPictures { [weak self] result in
            self?.currentState = .id
            switch result {
            case .success(let pictures):
                self?.posts = pictures.map { pictureModel in
                    DetailModel(
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: self?.favoritesStorage.isPostFavorite(post: pictureModel.title) ?? false,
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                }
                self?.currentState = .success
                self?.didItemsUpdated?()

            case .failure(let error):
                if let networkError = error as? SomeErrors {
                    switch networkError {
                    case .notNetworkConnection:
                        MainModel.errorMassege = "Отсутствует интернет-соединение. Попробуйте позже"
                    default:
                        MainModel.errorMassege = "Xnj-nj"
                    }
                }
                self?.currentState = .error
                self?.didItemsError?()
            }
        }
    }
    
    func favoritePost(for post: DetailModel) {
        guard let index = posts.firstIndex(where: { $0.title == post.title }) else { return }
        posts[index].isFavorite.toggle()
    }
}

struct DetailModel: Equatable {
    
    // MARK: - Internal Properties
    
    let imageUrlInString: String
    let title: String
    var isFavorite: Bool
    let content: String
    let dateCreation: String
    
    // MARK: - Initialization
    
    internal init(imageUrlInString: String, title: String, isFavorite: Bool, content: String, dateCreation: Date) {
        self.imageUrlInString = imageUrlInString
        self.title = title
        self.isFavorite = isFavorite
        self.content = content
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
    
        self.dateCreation = formatter.string(from: dateCreation)
    }
    
    // MARK: - Internal methods
    
    static func createDefault() -> DetailModel {
        let emptyModel = DetailModel(
            imageUrlInString: "",
            title: "",
            isFavorite: false,
            content: "",
            dateCreation: Date()
        )
        return emptyModel
    }
}
