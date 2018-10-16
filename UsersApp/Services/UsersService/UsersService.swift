//
//  UsersService.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/11/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

class UsersService: UsersServiceInput {
    
    // MARK: - Properties
    weak var output: UsersServiceOutput?
    let requestSender: RequestSender
    let requestBuilder: RequestBuilder
    
    // MARK: - Init
    init(requestSender: RequestSender, requestBuilder: RequestBuilder) {
        self.requestSender = requestSender
        self.requestBuilder = requestBuilder
    }
    
    func getUsers() {
        let request = self.requestBuilder.getUsers()
        self.requestSender.sendRequest(request, mainUrl: true, responseType: [UserResponse].self, success: { [weak self] (response) in
            self?.output?.successfullyGetUsers(response)
            },
        failure: { [weak self] (error) in
            self?.output?.handleError(error, completion: nil)
        })
    }
    
    func createUserOrEditWith(_ url: String, user: UserInputModel) {
        let request = self.requestBuilder.createUserOrEditWith(url, user: user)
        self.requestSender.sendRequest(request, mainUrl: true, responseType: EmptyAPIResponse.self, success: { [weak self] (response) in
            self?.output?.successfullyUpdateUser()
            },
        failure: { [weak self] (error) in
            self?.output?.handleError(error, completion: nil)
        })
    }
    
    func uploadImageForUser(_ imageVO: ImageVO, user: UserInputModel) {
        guard  let encodedData = imageVO.image.jpegData(compressionQuality: 1.0)?.base64EncodedData() else { return }
        let request = self.requestBuilder.uploadImage(encodedPhotoData: encodedData)
        self.requestSender.sendRequest(request, mainUrl: false, responseType: ImageResponse.self, success: { [weak self] (response) in
            self?.output?.successfullyUploadedImgForUser(response.link, user: user)
            },
        failure: { [weak self] (error) in
            self?.output?.handleError(error, completion: nil)
        })
    }

}
