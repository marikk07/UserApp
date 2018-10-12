//
//  UserResponse.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/11/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    let id: String
    let first_name: String
    let last_name: String
    let email: String
    let image_url: String
    let created: String
    let updated: String
}


