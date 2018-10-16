//
//  ImageResponse.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/16/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import Foundation

struct ImageResponse: Decodable {
    let id: String
    let title: String?
    let description: String?
    let datetime: Int
    let type: String
    let animated: Bool
    let width: Int
    let height: Int
    let size: Int
    let views: Int
    let bandwidth: Int
    let vote: Int?
    let favorite: Bool
    let nsfw: Int?
    let section: Int?
    let account_url: String?
    let account_id: Int?
    let is_ad: Bool
    let in_most_viral: Bool
    let has_sound: Bool
    let tags: [Int]?
    let ad_type: Int
    let ad_url: String
    let in_gallery: Bool
    let deletehash: String
    let name: String
    let link: String
}
