//
//  AbstractViewInput.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/12/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

protocol AbstractViewInput: class {
    func showLoader()
    func hideLoader()
    func showErrorAlertWithMessage(_ message: String)
}
