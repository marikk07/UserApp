//
//  UsersServiceOutput.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/11/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

protocol UsersServiceOutput: class, ErrorHandler {
    func successfullyGetUsers(_ users: [UserResponse])
    func successfullyUpdateUser()
    func successfullyUploadedImgForUser(_ url: String, user: UserInputModel)
}
