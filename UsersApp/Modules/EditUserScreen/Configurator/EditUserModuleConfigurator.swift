//
//  EditUserModuleConfigurator.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit

// MARK: - Configurator
class EditUserScreenModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? EditUserScreenViewController {
            configure(viewController: viewController)
        }
    }

    // MARK: Assembly
    private func configure(viewController: EditUserScreenViewController) {

        let router = EditUserScreenRouter()
        router.transitionHandler = viewController

        let presenter = EditUserScreenPresenter(view: viewController, router: router)

        let interactor = EditUserScreenInteractor(output: presenter)
        let userService = UsersService(requestSender: NetworkingManager(), requestBuilder: RequestBuilder())
        userService.output = interactor
        interactor.userService = userService
        interactor.emailValidator = EmailValidatorService()
            
        presenter.interactor = interactor
        viewController.output = presenter
    }

}
