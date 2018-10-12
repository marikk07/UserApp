//
//  EditUserModuleRouter.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

class EditUserScreenRouter: EditUserScreenRouterInput {
    weak var transitionHandler: TransitionHandler!
    
    func closeModule() {
        self.transitionHandler.closeCurrentModule(animated: true)
    }
}
