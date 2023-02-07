//
//  ProfileSrorage.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 19.08.2022.
//

import Foundation

protocol ProfileStorage {
    
    func getProfileInfo() throws -> ProfileModel
    func set(profile: ProfileModel) throws
    func removeProfile() throws
    
}
