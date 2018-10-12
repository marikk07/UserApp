//
//  ErrorResponse.swift
//  WeatherApp
//
//  Created by Maryan Pasichniak on 10/1/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

protocol ErrorHandler {
    func handleError(_ error: ApiError, completion: (()->())?)
}

struct ErrorResponse: Error, Decodable {
    let message: String
    let code: Int
}
