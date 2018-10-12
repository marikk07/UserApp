//
//  UserListModuleInteractorOutput.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import Foundation

protocol UserListModuleInteractorOutput: class {
    func successfullyGetUsers(_ users: [UserResponse])
    func failedWith(_ error: ApiError)
}
