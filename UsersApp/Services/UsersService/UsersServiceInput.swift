//
//  UsersServiceInput.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/11/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

protocol UsersServiceInput {
    func getUsers()
    func uploadImageForUser(_ imageVO: ImageVO, user: UserInputModel)
    func createUserOrEditWith(_ url: String, user: UserInputModel)
}
