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
    func createUserOrEditWith(firstName: String, lastName: String, email: String, id: String?)
}
