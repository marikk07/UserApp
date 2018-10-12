//
//  UserListModulePresenter.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

// MARK: - Class
class UserListModulePresenter: UserListModuleModuleInput, UserListModuleViewOutput, UserListModuleInteractorOutput {

    // MARK: - Viper properties
    weak var view: UserListModuleViewInput!
    var interactor: UserListModuleInteractorInput!
    var router: UserListModuleRouterInput!

    // MARK: - Init
    init(view: UserListModuleViewInput, router: UserListModuleRouterInput) {
        self.view = view
        self.router = router
    }

    // MARK: - UserListModuleViewOutput
    func viewIsReady() {
        self.view.showLoader()
        self.interactor.loadUsersData()
    }
    
    func failedWith(_ error: ApiError) {
        self.view.hideLoader()
    }
    
    
    func addButtonTouchedWith(_ user: UserResponse?) {
        self.router.pushEditModuleWith(self.interactor, user: user)
    }
    
    //MARK: - UserListModuleInteractorOutput
    func successfullyGetUsers(_ users: [UserResponse]) {
        self.view.hideLoader()
        self.view.updateWithUser(users)
    }
    
}
