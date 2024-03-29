//
//  UIImageView+ImageLoader.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 10.08.2022.
//

import Foundation
import UIKit

extension UIImageView {

    // MARK: - Internal Methods

    func loadImage(from url: URL) {
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }

}
