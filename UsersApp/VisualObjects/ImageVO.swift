//
//  ImageVO.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/15/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import UIKit

struct ImageVO {
    let image: UIImage
    
    init?(data: Data) {
        guard let image = UIImage(data: data) else {
            return nil
        }
        self.image = image
    }
    
    init(image: UIImage) {
        self.image = image
    }
}
