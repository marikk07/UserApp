//
//  ApiError.swift
//  WeatherApp
//
//  Created by Maryan Pasichniak on 10/1/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

protocol ApiErrorHandler {
    func handleError(_ error: ApiError, completion: (()->())?)
}

enum ApiErrorType {
    case wrongKey
    case failedRequest
    case failedToBuildUrl
    case wrongParametersForFunction
    case cannotConvertDataToImage
    case unknown(message: String)
}

struct ApiError: Error {
    let errorType: ApiErrorType
    
    init?(errorResponse: ErrorResponse, httpStatusCode: Int? = nil) {
        if httpStatusCode == 401 {
            self.errorType = .wrongKey
            return
        }
        
        switch errorResponse.message {
        default:
            self.errorType = .unknown(message: errorResponse.message)
        }
    }
    
    init(type: ApiErrorType) {
        self.errorType = type
    }
}
