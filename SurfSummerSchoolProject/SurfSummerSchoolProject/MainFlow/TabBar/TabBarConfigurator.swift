//
//  TabBarConfigurator.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 03.08.2022.
//

import Foundation
import UIKit

final class TabBarConfigurator {
    
    // MARK: - Private property
    
    private let allTab: [TabBarModel] = [.main, .favorite, .profile]
    
    // MARK: - Internal Methods
    
    func configure() -> UITabBarController {
        return getTabBarController()
    }
}

// MARK: - Private Methods

private extension TabBarConfigurator {
    
    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getViewControllers()
        
        return tabBarController
    }
    
    func getViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        allTab.forEach { tab in
            let controller = getCurrentViewController(tab: tab)
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = tabBarItem
            viewControllers.append(controller)
        }
        
        return viewControllers
    }
    
    func getCurrentViewController(tab: TabBarModel) -> UIViewController {
        switch tab {
        case .main:
            return wrappedInNavigationController(with: MainViewController(), title: tab.title)
        case .favorite:
            return wrappedInNavigationController(with: FavoriteViewController(), title: tab.title)
        case .profile:
            return wrappedInNavigationController(with: ProfileViewController(), title: tab.title)
        }
    }
    
    func wrappedInNavigationController(with: UIViewController, title: String) -> UINavigationController {
        with.title = title
        let navigationController = UINavigationController(rootViewController: with)
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
}
