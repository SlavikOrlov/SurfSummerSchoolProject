//
//  FavoriteModel.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 07.08.2022.
//

import Foundation
import UIKit

final class FavoriteModel {
    
    // MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    
    // MARK: - Properties
    
    var items: [FavoriteItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
    
    // MARK: - Methods
    
    func getPosts() {
        items = Array(repeating: FavoriteItemModel.createDefault(), count: 20)
    }
}
