//
//  UserResponse.swift
//  OnTheMap
//
//  Created by Renan Maganha on 01/07/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let firstName: String?
    let lastName: String?
    let nickname: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname
    }
}

