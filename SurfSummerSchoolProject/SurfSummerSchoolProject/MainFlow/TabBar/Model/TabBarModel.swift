//
//  TabBarModel.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 03.08.2022.
//

import Foundation
import UIKit

enum TabBarModel {
    case main
    case favorite
    case profile
    
    var title: String {
        switch self {
        case .main:
            return "Главная"
        case .favorite:
            return "Избранное"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .main:
            return ImagesExtension.mainTab
        case .favorite:
            return ImagesExtension.favoriteTab
        case .profile:
            return ImagesExtension.profileTab
        }
    }
    
    var selectedImage: UIImage? {
        return image
    }
}
