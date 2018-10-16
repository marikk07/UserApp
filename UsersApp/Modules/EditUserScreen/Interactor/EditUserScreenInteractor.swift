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
    func saveButtonTouchedWith(user: UserInputModel, imageVO: ImageVO) {
        if user.first_name.count < 1 || user.last_name.count < 1 || user.email.count < 1 {
                self.output.showErrorAlert(message: "Fill all fields")
            } else {
                let responce = self.emailValidator.validateEmail(user.email)
                switch responce {
                case .valid:
                    self.userService.uploadImageForUser(imageVO, user: user)
                case .error(let message):
                    self.output.showErrorAlert(message: message)
                }
            }
    }

}

extension EditUserScreenInteractor: UsersServiceOutput {
    
    func successfullyGetUsers(_ users: [UserResponse]) {
    }
    
    func successfullyUploadedImgForUser(_ url: String, user: UserInputModel)  {
        DispatchQueue.main.async {
            self.userService.createUserOrEditWith(url, user: user)
        }
        
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
