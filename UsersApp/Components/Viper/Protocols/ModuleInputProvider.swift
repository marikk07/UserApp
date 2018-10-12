//
//  ModuleInputProvider.swift
//
//
//  Created by Maryan Pasichniak on 10/4/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

// MARK: - ModuleInputProvider

protocol ModuleInputProvider {
	
	/// Module input for current object
	var moduleInitialInput: ModuleInput? { get }
}

