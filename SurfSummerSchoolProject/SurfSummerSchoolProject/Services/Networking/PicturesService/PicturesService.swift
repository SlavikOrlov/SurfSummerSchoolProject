//
//  PicturesService.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 10.08.2022.
//

import Foundation

struct PicturesService {

    // MARK: - Properties

    let dataTask = BaseNetworkTask<EmptyModel, [PictureResponseModel]>(
        inNeedInjectToken: true,
        method: .get,
        path: "picture/"
    )

    // MARK: - Internal Methods

    func loadPictures(_ onResponseWasReceived: @escaping (_ result: Result<[PictureResponseModel], Error>) -> Void) {
        dataTask.performRequest(onResponseWasReceived)
    }

}
