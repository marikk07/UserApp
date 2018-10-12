//
//  EditUserModuleInitializer.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit

class EditUserScreenModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var editUserModuleViewController: EditUserScreenViewController!

    override func awakeFromNib() {

        let configurator = EditUserScreenModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: editUserModuleViewController)
    }

}
