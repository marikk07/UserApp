//
//  EditUserModulePresenter.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

// MARK: - Class
class EditUserScreenPresenter: EditUserScreenModuleInput, EditUserScreenViewOutput, EditUserScreenInteractorOutput {

    // MARK: - Viper properties
    weak var view: EditUserScreenViewInput!
    var interactor: EditUserScreenInteractorInput!
    var router: EditUserScreenRouterInput!
    weak var delegate: EditUserScreenDelegate? {
        didSet { interactor.delegate = delegate }
    }
    var inputUser: UserResponse? {
        didSet { view.inputUser = inputUser }
    }
    
    // MARK: - Init
    init(view: EditUserScreenViewInput, router: EditUserScreenRouterInput) {
        self.view = view
        self.router = router
    }

    // MARK: - EditUserScreenInteractorOutput
    func viewIsReady() {
    }
    
    func showErrorAlert(message: String) {
        self.view.hideLoader()
        self.view.showErrorAlertWithMessage(message)
    }
    
    func successfullyUpdateUsers() {
        self.view.hideLoader()
        self.closeModule()
    }
    
    func failedWith(_ error: ApiError) {
        self.view.hideLoader()
        self.view.showErrorAlertWithMessage(error.localizedDescription)
    }
    
    func closeModule() {
        self.router.closeModule()
    }
    
    // MARK: - EditUserScreenViewOutput
    func saveButtonTouchedWith(firstName: String?, lastName: String?, email: String?, id: String?) {
        self.view.showLoader()
        self.interactor.saveButtonTouchedWith(firstName: firstName, lastName: lastName, email: email, id: id)
    }
    
    
}
