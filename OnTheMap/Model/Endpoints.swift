//
//  Endpoints.swift
//  OnTheMap
//
//  Created by Nuxen on 23/06/20.
//  Copyright © 2020 renan maganha. All rights reserved.
//

import Foundation

enum Endpoints {
    static let baseURL = "https://onthemap-api.udacity.com/v1"
    
    case getStudentLocation
    
    var stringValue: String {
        switch self {
        case .getStudentLocation: return Endpoints.baseURL + "/StudentLocation"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
