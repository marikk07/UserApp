//
//  UserListModuleInitializer.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit

class UserListModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var userListModuleViewController: UserListModuleViewController!

    override func awakeFromNib() {

        let configurator = UserListModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: userListModuleViewController)
    }

}
