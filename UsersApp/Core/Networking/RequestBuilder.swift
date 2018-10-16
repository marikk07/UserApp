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
    
    private var clientID = "b92dda074953951"
    
    func getUsers() -> APIRequest {
        let url = ApiMethod.users.rawValue + ".php"
        let request = self.commonAPIRequest(stringUrl: url, httpMethod: .get)
        return request
    }
    
    func createUserOrEditWith(_ imgUrl: String, user: UserInputModel) -> APIRequest {
        var url = ""
        if let id = user.id {
            url = url + ApiMethod.edit.rawValue + "user_id=\(id)"
        } else {
            url = ApiMethod.users.rawValue + ".php"
        }
        var request = self.commonAPIRequest(stringUrl: url, httpMethod: .post)
        let params = ["first_name": user.first_name,
                      "last_name": user.last_name,
                      "email": user.email,
                      "image_url": imgUrl]
        request.parameters =  self.wrapParametersWithDataKey(parameters: params)
        return request
    }
    
    func uploadImage(encodedPhotoData: Data) -> APIRequest {
        let url = ApiMethod.image.rawValue
        let headers = ["Authorization" : "Client-ID b92dda074953951"]
        let request = APIRequest(apiMethod: url, httpMethod: .post,
                                       headers: headers, httpBody: encodedPhotoData)
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

