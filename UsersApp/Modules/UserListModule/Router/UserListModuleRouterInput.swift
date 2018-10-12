//
//  UserListModuleRouterInput.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import Foundation

protocol UserListModuleRouterInput: class {
    func pushEditModuleWith(_ delegate: EditUserScreenDelegate, user: UserResponse?)
}
