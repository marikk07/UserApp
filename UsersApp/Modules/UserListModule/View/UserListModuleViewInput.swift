//
//  UserListModuleViewInput.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

protocol UserListModuleViewInput: AbstractViewInput {
    func setupInitialState()
    func updateWithUser(_ userData: [UserResponse])
}
