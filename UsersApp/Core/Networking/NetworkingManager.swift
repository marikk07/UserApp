//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by Maryan Pasichniak on 10/1/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkingManager: RequestSender {
    
    // MARK: - Properties
    private let mainApi = "https://cua-users.herokuapp.com/"
    
    // MARK: - SaQureRequestSender
    func sendRequest<Response>(_ request: APIRequest,
                               responseType: Response.Type,
                               success: @escaping (Response) -> (),
                               failure: @escaping (ApiError) -> ()) where Response : Decodable {
        
        guard let urlRequest = self.makeUrlRequest(saqureRequest: request) else {
            failure(ApiError(type: .failedToBuildUrl))
            return
        }
        
        Alamofire.request(urlRequest)
            .responseData(queue: DispatchQueue.global(), completionHandler: { (response) in
                
                // Handle API response
                switch response.result {
                case .success(let data):
                    // Decode data to a response instance
                    switch self.decodeData(data: data, responseType: responseType) {
                    case (let responseObject, nil) where responseObject != nil:
                        success(responseObject!)
                    case (nil, let error) where error != nil:
                        if let error = ApiError(errorResponse: error!, httpStatusCode: response.response?.statusCode) {
                            failure(error)
                        } else {
                            failure(ApiError(type: .failedRequest))
                        }
                    case (_,_):
                        #if DEBUG
                        fatalError("Unexpected result")
                        #else
                        failure(Error(type: .failedRequest))
                        #endif
                    }
                case .failure(_):
                    failure(ApiError(type: .failedRequest))
                }
        })
    }
    
    // MARK: - Private
    fileprivate func decodeData<Response>(data: Data, responseType: Response.Type) -> (Response?, ErrorResponse?) where Response: Decodable {
        if responseType == EmptyAPIResponse.self, data.isEmpty {
            return (EmptyAPIResponse() as? Response, nil)
        }
        do {
            let responseObject = try JSONDecoder().decode(Response.self, from: data)
            return (responseObject, nil)
        } catch {
            let error: ErrorResponse = ErrorResponse(message: "Unable to decode response", code: -99999)
            return (nil,error)
        }
    }
    
    fileprivate func makeUrlRequest(saqureRequest: APIRequest) -> URLRequest? {
        guard let url = self.createURLWith(saqureRequest.apiMethod) else {
            return nil
        }
        
        var urlRequest: URLRequest?
        do {
            let tempUrlRequest = try URLRequest(url: url, method: saqureRequest.httpMethod, headers: nil)
            switch saqureRequest.httpMethod {
            case .get, .head, .delete:
                let encoding = URLEncoding(destination: .queryString)
                urlRequest = try encoding.encode(tempUrlRequest, with: saqureRequest.parameters)
            default:
                if let httpBody = saqureRequest.httpBody {
                    urlRequest = tempUrlRequest
                    urlRequest?.httpBody = httpBody
                } else {
                    let encoding = JSONEncoding(options: [])
                    urlRequest = try encoding.encode(tempUrlRequest, with: saqureRequest.parameters)
                }
            }
        } catch {
            #if DEBUG
            fatalError(error.localizedDescription)
            #else
            return nil
            #endif
        }
        
        return urlRequest
    }
    
    fileprivate func createURLWith(_ method: String) -> URL? {
        let final = self.mainApi
        return URL(string: final + method)
    }

}
