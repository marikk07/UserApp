//
//  RequestSender.swift
//  WeatherApp
//
//  Created by Maryan Pasichniak on 10/1/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

protocol RequestSender {
    func sendRequest<Response>(_ request: APIRequest,
                               mainUrl: Bool,
                               responseType: Response.Type,
                               success: @escaping (Response) -> (),
                               failure: @escaping (ApiError) -> ()) where Response: Decodable
}
