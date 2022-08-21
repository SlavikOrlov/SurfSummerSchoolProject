//
//  BaseProfileStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 19.08.2022.
//

import Foundation

struct BaseProfileStorage: ProfileStorage {
    
    // MARK: - Private Properties

    private var unprotectedStorage: UserDefaults {
        UserDefaults.standard
    }
    
    //MARK: - Constants
    
    private let avatarKey: String = "avatar"
    private let firstNameKey: String = "firstName"
    private let secondNameKey: String = "secondName"
    private let aboutKey: String = "about"
    private let cityKey: String = "city"
    private let phoneKey: String = "phone"
    private let emailKey: String = "email"
    
    // MARK: - TokenStorage

    func getProfileInfo() throws -> ProfileModel {
        let profile = try getProfileFromStorage()
        return profile
    }
    
    func set(profile: ProfileModel) throws {
        removeProfileFromStorage()
        saveProfileInStorage(profile: profile)
    }
    
    func removeProfile() throws {
        removeProfileFromStorage()
    }
}

// MARK: - Privat Methods

private extension BaseProfileStorage {
    
    enum Error: Swift.Error {
        case profileWasNotFound
    }
    
    func getProfileFromStorage() throws -> ProfileModel {
        guard let profileAvatar =
                unprotectedStorage.value(forKey: avatarKey) as? String,
              let profileFirstName =
                unprotectedStorage.value(forKey: firstNameKey) as? String,
              let profileSecondName =
                unprotectedStorage.value(forKey: secondNameKey) as? String,
              let profileAbout =
                unprotectedStorage.value(forKey: aboutKey) as? String,
              let profileCity =
                unprotectedStorage.value(forKey: cityKey) as? String,
              let profilePhone =
                unprotectedStorage.value(forKey: phoneKey) as? String,
              let profileEmail =
                unprotectedStorage.value(forKey: emailKey) as? String
        else {
            throw Error.profileWasNotFound
        }
        let profile = ProfileModel(
            avatar: profileAvatar,
            firstName: profileFirstName,
            secondName: profileSecondName,
            about: profileAbout,
            city: profileCity,
            phone: profilePhone,
            email: profileEmail
        )
        return profile
    }
    
    func saveProfileInStorage(profile: ProfileModel) {
        unprotectedStorage.set(profile.avatar, forKey: avatarKey)
        unprotectedStorage.set(profile.firstName, forKey: firstNameKey)
        unprotectedStorage.set(profile.secondName, forKey: secondNameKey)
        unprotectedStorage.set(profile.about, forKey: aboutKey)
        unprotectedStorage.set(profile.city, forKey: cityKey)
        unprotectedStorage.set(profile.phone, forKey: phoneKey)
        unprotectedStorage.set(profile.email, forKey: emailKey)
    }
    
    func removeProfileFromStorage() {
        unprotectedStorage.set(nil, forKey: avatarKey)
        unprotectedStorage.set(nil, forKey: firstNameKey)
        unprotectedStorage.set(nil, forKey: secondNameKey)
        unprotectedStorage.set(nil, forKey: aboutKey)
        unprotectedStorage.set(nil, forKey: cityKey)
        unprotectedStorage.set(nil, forKey: phoneKey)
        unprotectedStorage.set(nil, forKey: emailKey)
    }
}

