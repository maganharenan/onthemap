//
//  DeleteSessionResponse.swift
//  OnTheMap
//
//  Created by Nuxen on 25/06/20.
//  Copyright © 2020 renan maganha. All rights reserved.
//

import Foundation

struct DeleteSessionResponse: Codable {
    let session: Session
    
    struct Session: Codable {
        let id: String
        let expiration: String
    }
}
