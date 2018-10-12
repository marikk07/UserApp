//
//  UserListModuleInteractor.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//
import Foundation

class UserListModuleInteractor: UserListModuleInteractorInput {
    
    // MARK: - Properties
    weak var output: UserListModuleInteractorOutput!
    var userService: UsersServiceInput!
    
    // MARK: - Init
    init(output: UserListModuleInteractorOutput) {
        self.output = output
    }
    
    // MARK: - UserListModuleInteractorInput
    func loadUsersData() {
        DispatchQueue.global().async {
            self.userService.getUsers()
        }
    }
    
    // MARK: - EditUserScreenDelegate
    func reloadUsersData() {
        self.loadUsersData()
    }
    
}

extension UserListModuleInteractor: UsersServiceOutput {
    func successfullyGetUsers(_ users: [UserResponse]) {
        DispatchQueue.main.async {
            self.output.successfullyGetUsers(users)
        }
    }
    
    func successfullyUpdateUser() {
    }
    
    func handleError(_ error: ApiError, completion: (() -> ())?) {
        DispatchQueue.main.async {
            self.output.failedWith(error)
        }
    }
    
    
}
