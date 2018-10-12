//
//  UIViewController+TransitionHandler.swift
//
//
//  Created by Maryan Pasichniak on 10/4/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import UIKit

typealias TransitionSetupBlock<T> = (T) -> Void

// MARK: - TransitionHandler
protocol TransitionHandler: class {
	
	var moduleInput: ModuleInput? { get set }
	    
	/// Standard performSegueWithIdentifier
	///
	/// - Parameter segueIdentifier: Given segue identifier
	func performSegue(_ segueIdentifier: String)
	
	/// Transition with segue identifier and setup block
	///
	/// - Parameters:
	///   - segueIdentifier: Given segue identifier
	///   - type: Moduleinput type
	///   - setup: Block for setup ModuleInput
	func openModuleUsingSegue<T>(_ segueIdentifier: String, to type: T.Type, setup: @escaping TransitionSetupBlock<T>)
    
	/// Close current module
	///
	/// - Parameter animated: true if need to animate transition
	func closeCurrentModule(animated: Bool)
        
    /// Removes all viewcontrollers from UINavigationController.viewControllers except current module's viewController.
    func clearNavigationStack()
}


