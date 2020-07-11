//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Renan Maganha on 21/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import MapKit

struct StudentResults: Codable {
    var results: [StudentLocation]
}

struct StudentLocation: Codable, Equatable, Hashable {
    let firstName:  String
    let lastName:   String
    let longitude:  Double
    let latitude:   Double
    let mapString:  String
    let mediaURL:   String
    let uniqueKey:  String
    let objectId:   String
    let createdAt:  String
    let updatedAt:  String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case longitude
        case latitude
        case mapString
        case mediaURL
        case uniqueKey
        case objectId
        case createdAt
        case updatedAt
    }
}


{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}
