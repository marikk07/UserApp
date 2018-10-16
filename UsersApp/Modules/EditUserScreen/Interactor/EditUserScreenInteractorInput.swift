//
//  EditUserModuleInteractorInput.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import Foundation

protocol EditUserScreenInteractorInput {
    var delegate: EditUserScreenDelegate? { get set }
    func saveButtonTouchedWith(user: UserInputModel, imageVO: ImageVO)
}
