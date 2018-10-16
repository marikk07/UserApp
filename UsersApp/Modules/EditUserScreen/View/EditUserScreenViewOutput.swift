//
//  EditUserModuleViewOutput.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

protocol EditUserScreenViewOutput {
    func viewIsReady()
    func showPhotoPicker()
    func saveButtonTouchedWith(user: UserInputModel, imageVO: ImageVO)
}
