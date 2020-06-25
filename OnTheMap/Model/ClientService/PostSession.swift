//
//  Udacity.swift
//  OnTheMap
//
//  Created by Renan Maganha on 24/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

struct PostSession: Codable {
    let udacity: Udacity
    
    struct Udacity: Codable {
        let username: String
        let password: String
    }
}


