//
//  UserListModuleConfigurator.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit

// MARK: - Configurator
class UserListModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? UserListModuleViewController {
            configure(viewController: viewController)
        }
    }

    // MARK: Assembly
    private func configure(viewController: UserListModuleViewController) {

        let router = UserListModuleRouter()
        router.transitionHandler = viewController

        let presenter = UserListModulePresenter(view: viewController, router: router)

        let interactor = UserListModuleInteractor(output: presenter)
        let userService = UsersService(requestSender: NetworkingManager(), requestBuilder: RequestBuilder())
        userService.output = interactor
        interactor.userService = userService
        
        presenter.interactor = interactor
        viewController.output = presenter
    }

}
