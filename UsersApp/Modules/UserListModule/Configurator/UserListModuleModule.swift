//
//  UserListModuleModule.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit

class UserListModuleModule: Module {
    typealias Input = UserListModulePresenter
    
    func instantiateTransitionHandler() -> UIViewController {
        let storyboard = UIStoryboard(name: "UserListModule", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? UserListModuleViewController else {
            fatalError("Could not instantiate UserListModuleViewController")
        }
        return vc
    }

    required init() {
    }
}