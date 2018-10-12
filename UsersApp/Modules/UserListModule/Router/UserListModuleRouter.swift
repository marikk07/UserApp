//
//  UserListModuleRouter.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

class UserListModuleRouter: UserListModuleRouterInput {
    weak var transitionHandler: TransitionHandler!
    
    //MARK: UserListModuleRouterInput    
    func pushEditModuleWith(_ delegate:EditUserScreenDelegate,  user: UserResponse?) {
        self.transitionHandler.openModuleUsingSegue(Const.Segue.editUser, to: EditUserScreenModuleInput.self) { (moduleInput) in
            moduleInput.delegate = delegate
            moduleInput.inputUser = user
        }
    }

}
