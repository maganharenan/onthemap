//
//  Udacity.swift
//  OnTheMap
//
//  Created by Nuxen on 24/06/20.
//  Copyright © 2020 renan maganha. All rights reserved.
//

import Foundation

struct PostSession: Codable {
    let udacity: Udacity
    
    struct Udacity: Codable {
        let username: String
        let password: String
    }
}


