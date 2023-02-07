//
//  NetworkTask.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 10.08.2022.
//

import Foundation

protocol NetworkTask {
    
    associatedtype Input: Encodable
    associatedtype Output: Decodable

    // MARK: - Properties

    var baseURL: URL? { get }
    var path: String { get }
    var completedURL: URL? { get }
    var method: NetworkMethod { get }

    // MARK: - Internal Methods

    func performRequest(
        input: Input,
        _ onResponseWasReceived: @escaping (_ result: Result<Output, Error>) -> Void
    )

}

// MARK: - Internal Methods

extension NetworkTask {

    var completedURL: URL? {
        baseURL?.appendingPathComponent(path)
    }

}
