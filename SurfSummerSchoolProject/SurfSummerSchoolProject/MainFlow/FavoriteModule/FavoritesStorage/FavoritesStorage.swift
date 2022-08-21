//
//  FavoritesStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 20.08.2022.
//

import Foundation

class FavoritesStorage {
    
    // MARK: - Properties
    
    static let shared = FavoritesStorage()
    var myFavorites = [String]()
    
    //MARK: - Private property
    
    private let keyForFavoritesStorage = "favoritePosts"
    private let defaults = UserDefaults.standard
    private init() {
        let favorites = defaults.stringArray(forKey: keyForFavoritesStorage) ?? [String]()
        for favorite in favorites {
            addFavorite(favoritePost: favorite)
        }
    }
    
    //MARK: - Public methods
    
    func isPostFavorite(post: String) -> Bool {
        if myFavorites.contains(post) {
            return true
        } else {
            return false
        }
    }
    
    func addFavorite(favoritePost: String) {
        if !myFavorites.contains(where: { $0 == favoritePost }) {
            myFavorites.append(favoritePost)
        }
        defaults.set(myFavorites, forKey: keyForFavoritesStorage)
        MainViewController.favoriteTapStatus = true
        FavoriteViewController.favoriteTapStatus = true
    }
    
    func removeFavorite(favoritePost: String) {
        guard let index = myFavorites.firstIndex(of: favoritePost) else { return }
        myFavorites.remove(at: index)
        defaults.set(myFavorites, forKey: keyForFavoritesStorage)
        MainViewController.favoriteTapStatus = true
        FavoriteViewController.favoriteTapStatus = true
    }
}
