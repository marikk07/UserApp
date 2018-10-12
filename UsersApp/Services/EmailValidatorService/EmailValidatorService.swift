//
//  EmailValidatorService.swift
//  SaQure
//
//  Created by Maryan Pasichniak on 7/30/18.
//  Copyright © 2018 SaQure. All rights reserved.
//

import Foundation

struct EmailValidatorService: EmailValidatorServiceInput {
    
    func validateEmail(_ email: String?) -> ValidatorResponse {
        guard let email = email, !email.isEmpty else {
            let message = "error.validation.email.empty"
            return ValidatorResponse.error(message: message)
        }
        if !self.isValidEmail(email: email) {
            let message = "error.validation.email.invalid"
            return ValidatorResponse.error(message: message)
        }
        return ValidatorResponse.valid
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
}
