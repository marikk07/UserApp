//
//  EditUserModuleInteractorOutput.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import Foundation

protocol EditUserScreenInteractorOutput: class {
    func showErrorAlert(message: String)
    func successfullyUpdateUsers()
    func failedWith(_ error: ApiError)
}
