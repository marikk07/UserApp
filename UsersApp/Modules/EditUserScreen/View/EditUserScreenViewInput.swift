//
//  EditUserModuleViewInput.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

protocol EditUserScreenViewInput: AbstractViewInput {
    var inputUser: UserResponse? { get set }
    func setupInitialState()
}
