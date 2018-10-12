//
//  AbstractViewController.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/12/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {
    weak var loader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - AbstractViewInput
    func showLoader() {
        if self.loader == nil {
            let loader = UIActivityIndicatorView(style: .whiteLarge)
            loader.hidesWhenStopped = true
            loader.color = UIColor.black
            self.view.addSubview(loader)
            self.view.bringSubviewToFront(loader)
            self.loader = loader
        }
        self.loader?.center = self.view.center
        self.loader?.startAnimating()
        if !UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func hideLoader() {
        self.loader?.stopAnimating()
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    func showErrorAlertWithMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
