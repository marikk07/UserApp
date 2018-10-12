//
//  EditUserModuleModule.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit

class EditUserScreenModule: Module {
    typealias Input = EditUserScreenPresenter
    
    func instantiateTransitionHandler() -> UIViewController {
        let storyboard = UIStoryboard(name: "EditUserModule", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? EditUserScreenViewController else {
            fatalError("Could not instantiate EditUserModuleViewController")
        }
        return vc
    }

    required init() {
    }
}
