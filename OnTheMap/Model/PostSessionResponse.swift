//
//  PostSessionResponse.swift
//  OnTheMap
//
//  Created by Renan Maganha on 24/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

struct PostSessionResponse: Codable {
    let account: Account
    let session: Session
    
    struct Account: Codable {
        let registered: Bool
        let key: String
    }

    struct Session: Codable {
        let id: String
        let expiration: String
    }
}
