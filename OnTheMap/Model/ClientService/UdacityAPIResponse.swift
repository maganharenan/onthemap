//
//  UdacityAPIResponse.swift
//  OnTheMap
//
//  Created by Renan Maganha on 28/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

struct UdacityAPIResponse: Codable {
    let status: Int
    let error: String
}

extension UdacityAPIResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
