//
//  EditUserModuleInteractor.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//
import Foundation

protocol EditUserScreenDelegate: class {
    func reloadUsersData()
}

class EditUserScreenInteractor: EditUserScreenInteractorInput {

    // MARK: - Properties
    weak var output: EditUserScreenInteractorOutput!
    var emailValidator: EmailValidatorServiceInput!
    var userService: UsersServiceInput!
    weak var delegate: EditUserScreenDelegate?
    
    // MARK: - Init
    init(output: EditUserScreenInteractorOutput) {
        self.output = output
    }

    // MARK: - EditUserScreenInteractorInput
    func saveButtonTouchedWith(firstName: String?, lastName: String?, email: String?, id: String?) {
        if let firstName = firstName, let lastName = lastName, let email = email {
            if firstName.count < 1 || lastName.count < 1 || email.count < 1 {
                self.output.showErrorAlert(message: "Fill all fields")
            } else {
                let responce = self.emailValidator.validateEmail(email)
                switch responce {
                case .valid:
                    self.userService.createUserOrEditWith(firstName: firstName, lastName: lastName, email: email, id: id)
                case .error(let message):
                    self.output.showErrorAlert(message: message)
                }
            }
        }
    }

}

extension EditUserScreenInteractor: UsersServiceOutput {
    
    func successfullyGetUsers(_ users: [UserResponse]) {
    }
    
    func successfullyUpdateUser() {
        DispatchQueue.main.async {
            self.output.successfullyUpdateUsers()
            self.delegate?.reloadUsersData()
        }
    }
    
    func handleError(_ error: ApiError, completion: (() -> ())?) {
        DispatchQueue.main.async {
            self.output.failedWith(error)
        }
    }

}
