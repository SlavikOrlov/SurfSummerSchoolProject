//
//  ImageLoader.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 10.08.2022.
//

import Foundation
import UIKit

struct ImageLoader {
    
    // MARK: - Properties

    let queueForLoad = DispatchQueue.global(qos: .utility)
    let session = URLSession(configuration: .default)

    // MARK: - Internal Methods

    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                onLoadWasCompleted(.failure(error))
            }
            if let data = data, let image = UIImage(data: data) {
                onLoadWasCompleted(.success(image))
            }
        }
        .resume()
    }

}
