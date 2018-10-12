//
//  RequestBuilder.swift
//  WeatherApp
//
//  Created by Maryan Pasichniak on 10/2/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation
import Alamofire

struct RequestBuilder {
    
    func getUsers() -> APIRequest {
        let url = ApiMethod.users.rawValue + ".php"
        let request = self.commonAPIRequest(stringUrl: url, httpMethod: .get)
        return request
    }
    
    func createUserOrEditWith(firstName: String, lastName: String, email: String, id: String?) -> APIRequest {
        var url = ""
        if let id = id {
            url = url + ApiMethod.edit.rawValue + "user_id=\(id)"
        } else {
            url = ApiMethod.users.rawValue + ".php"
        }
        var request = self.commonAPIRequest(stringUrl: url, httpMethod: .post)
        let params = ["first_name": firstName,
                      "last_name": lastName,
                      "email": email,
                      "image_url": ""]
        request.parameters =  self.wrapParametersWithDataKey(parameters: params)
        return request
    }
    
    // MARK: - Private
    private func commonAPIRequest(stringUrl: String, httpMethod: HTTPMethod) -> APIRequest {
        return APIRequest(apiMethod: stringUrl, httpMethod: httpMethod)
    }
    
    private func wrapParametersWithDataKey(parameters: [String: Any]) -> [String: Any] {
        return ["user": parameters]
    }
}

