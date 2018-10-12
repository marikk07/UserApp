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
        self.requestSender.sendRequest(request, responseType: [UserResponse].self, success: { [weak self] (response) in
            self?.output?.successfullyGetUsers(response)
            },
        failure: { [weak self] (error) in
            self?.output?.handleError(error, completion: nil)
        })
    }
    
    func createUserOrEditWith(firstName: String, lastName: String, email: String, id: String?) {
        let request = self.requestBuilder.createUserOrEditWith(firstName: firstName, lastName: lastName, email: email, id: id)
        self.requestSender.sendRequest(request, responseType: EmptyAPIResponse.self, success: { [weak self] (response) in
            self?.output?.successfullyUpdateUser()
            },
        failure: { [weak self] (error) in
            self?.output?.handleError(error, completion: nil)
        })
    }

}
