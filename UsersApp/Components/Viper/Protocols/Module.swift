//
//  Module.swift
//
//  Created by Maryan Pasichniak on 10/4/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import UIKit

// MARK: - Module

protocol Module {
	
	associatedtype Input
	
	init()
	
	/// Instantiate transition handler
	///
	/// - Returns: UIViewController instance
	func instantiateTransitionHandler() -> UIViewController
}

