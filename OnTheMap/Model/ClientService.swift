//
//  ClientService.swift
//  OnTheMap
//
//  Created by Nuxen on 24/06/20.
//  Copyright © 2020 renan maganha. All rights reserved.
//

import Foundation

protocol ClientService {
    var registered: Bool? { get }
    var key: String? { get }
    var id: String? { get }
    var expiration: String? { get }
    
    func postSession(username: String, password: String, completion: @escaping (PostSessionResponse?, Error?) -> Void)
}
