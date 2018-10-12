//
//  UIViewController+TransitionHandler.swift
//
//
//  Created by Maryan Pasichniak on 10/4/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

// MARK: - ModuleInput

protocol ModuleInput: class {
    
    /// Set module output for the current module
    ///
    /// - Parameter moduleOutput: ModuleOutput instance
    func setModuleOutput(_ moduleOutput: ModuleOutput)
}

extension ModuleInput {
    func setModuleOutput(_ moduleOutput: ModuleOutput) {
        
    }
}
