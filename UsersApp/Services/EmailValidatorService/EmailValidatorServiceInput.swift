//
//  EmailValidatorServiceInput.swift
//  SaQure
//
//  Created by Maryan Pasichniak on 7/30/18.
//  Copyright © 2018 SaQure. All rights reserved.
//

import Foundation

protocol EmailValidatorServiceInput {
    func validateEmail(_ email: String?) -> ValidatorResponse
}
