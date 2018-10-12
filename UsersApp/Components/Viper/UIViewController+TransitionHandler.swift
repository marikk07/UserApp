//
//  UIViewController+TransitionHandler.swift
//  WeatherApp
//
//  Created by maryan on 01/10/2018.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//


import UIKit

extension UIViewController {
    
    func removeFromViewControllerContainer() {
        self.didMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}

// MARK: - TransitionHandler
extension UIViewController: TransitionHandler {
    func modallyPresentAuthorizationStack() {
        
    }
    
    func dismissAuthorizationStack() {
        
    }
    
        
    private struct ModuleInputAssociatedKey {
        static var moduleInput: ModuleInput?
    }
    
    var moduleInput: ModuleInput? {
        get {
            guard let result = objc_getAssociatedObject(self, &ModuleInputAssociatedKey.moduleInput) as? ModuleInput else {
                if let result = (self as? ModuleInputProvider)?.moduleInitialInput {
                    return result
                } else {
                    fatalError("Your UIViewController must implement protocol 'ModuleInputProvider'!")
                }
            }
            return result
        }
        
        set (moduleInput) {
            objc_setAssociatedObject(self, &ModuleInputAssociatedKey.moduleInput, moduleInput, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
        
    func performSegue(_ segueIdentifier: String) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }
        
    func openModuleUsingSegue<T>(_ segueIdentifier: String, to type: T.Type, setup: @escaping (T) -> Void) {
        self.performSegue(withIdentifier: segueIdentifier, sender: nil) { segue in
            
            var destination = segue.destination
            
            guard let moduleInput = destination.moduleInput as? T else {
                #if DEBUG
                fatalError("Cannot cast controller \(String(describing: destination.self)) to expected type \(type)")
                #else
                return
                #endif
            }
            
            if destination is UINavigationController {
                destination = (segue.destination as? UINavigationController)?.topViewController ?? segue.destination
            }
            
            setup(moduleInput)
        }
    }


    
    func closeCurrentModule(animated: Bool) {
        if let parent = parent as? UINavigationController, parent.children.count > 1 {
            for (i, vc) in parent.viewControllers.enumerated() {
                if self === vc {
                    if i != parent.viewControllers.count - 1 {
                        var viewControllers = parent.viewControllers
                        viewControllers.remove(at: i)
                        parent.setViewControllers(viewControllers, animated: false)
                    } else {
                        parent.popViewController(animated: animated)
                    }
                }
            }
        } else if let _ = presentingViewController {
            dismiss(animated: animated, completion: nil)
        } else {
            removeFromParent()
            view?.removeFromSuperview()
        }
    }
    
    func clearNavigationStack() {
        if let navController = self.navigationController {
            let viewControllers = navController.viewControllers
            let newArray = viewControllers.filter({$0 === self})
            navController.setViewControllers(newArray, animated: false)
        }
    }
}

// MARK: - Swizzling prepare(for:sender:)
extension UIViewController {
    
    class Value {
        
        let value: Any?
        
        init(_ value: Any?) {
            self.value = value
        }
    }

    @nonobjc static var PrepareForSegueKey = "com.incetro.method.prepareForSegue"
    
    typealias PerformSegueConfig = (UIStoryboardSegue) -> ()
    
    var performSegueConfig: PerformSegueConfig? {
        get {
            let value = objc_getAssociatedObject(self, &UIViewController.PrepareForSegueKey) as? Value
            return value?.value as? PerformSegueConfig
        }
        
        set {
            objc_setAssociatedObject(self, &UIViewController.PrepareForSegueKey, Value(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public static var isPrepareForSegueSwizzled: Bool {
        if let _ = originalPrepareForSegue {
            return true
        } else {
            return false
        }
    }

    private static var originalPrepareForSegue: Method? = nil
    public static var swizzlePrepareForSegue: Void {
        let instance = UIViewController()
        let aClass: AnyClass! = object_getClass(instance)

        var originalMethod: Method?
        var swizzledMethod: Method?

        switch UIViewController.originalPrepareForSegue {
        case nil:
            originalMethod = class_getInstanceMethod(aClass, #selector(prepare(for:sender:)))
            UIViewController.originalPrepareForSegue = originalMethod
            swizzledMethod = class_getInstanceMethod(aClass, #selector(swizzledPrepare(for:sender:)))
        case let alreadySwizzled:
            originalMethod = class_getInstanceMethod(aClass, #selector(swizzledPrepare(for:sender:)))
            swizzledMethod = alreadySwizzled
            UIViewController.originalPrepareForSegue = nil
        }

        if let original = originalMethod, let swizzled = swizzledMethod {
            method_exchangeImplementations(original, swizzled)
        }
    }

    func performSegue(withIdentifier identifier: String, sender: Any?, completion: @escaping PerformSegueConfig) {
        performSegueConfig = completion
        performSegue(withIdentifier: identifier, sender: sender)
    }

    @objc func swizzledPrepare(for segue: UIStoryboardSegue, sender: Any?) {
        performSegueConfig?(segue)
        swizzledPrepare(for: segue, sender: sender)
        performSegueConfig = nil
    }
}
