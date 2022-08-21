//
//  SomeErrors.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 20.08.2022.
//

import Foundation

enum SomeErrors: Error {
    case unknownError
    case urlWasNotFound
    case urlComponentWasNotCreated
    case parametersIsNotValidJsonObject
    case badRequest([String:String])
    case notNetworkConnection
    case unknownServerError
    case nonAuthorizedAccess
}
