//
//  DeleteSessionResponse.swift
//  OnTheMap
//
//  Created by Renan Maganha on 25/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

struct DeleteSessionResponse: Codable {
    let session: Session
    
    struct Session: Codable {
        let id: String
        let expiration: String
    }
}
