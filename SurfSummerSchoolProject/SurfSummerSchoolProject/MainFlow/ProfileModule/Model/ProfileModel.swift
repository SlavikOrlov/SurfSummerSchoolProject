//
//  ProfileModel.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 19.08.2022.
//

import Foundation

struct ProfileModel: Decodable {
    
    let avatar: String
    let firstName: String
    let lastName: String
    let about: String
    let city: String
    let phone: String
    let email: String
}

struct ProfileExample {
    static let shared = ProfileExample()
    let profileModel: ProfileModel
    
    init() {
        let storage = BaseProfileStorage()
        do {
        let profile = try storage.getProfileInfo()
        self.profileModel = profile
        } catch {
        print(error)
            self.profileModel = ProfileModel(
                avatar: "",
                firstName: "Вячеслав",
                lastName: "Орлов",
                about: "Что-то пошло не так!",
                city: "Санкт-Петербург",
                phone: "+7 (9**) *** ** **",
                email: "slava@surfstudio.ru"
            )
        }
    }
}
