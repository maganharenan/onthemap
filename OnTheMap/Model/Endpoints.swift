//
//  Endpoints.swift
//  OnTheMap
//
//  Created by Renan Maganha on 23/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

enum Endpoints {
    static let baseURL = "https://onthemap-api.udacity.com/v1"
    
    case getStudentLocation
    case postSession
    
    var stringValue: String {
        switch self {
        case .getStudentLocation: return Endpoints.baseURL + "/StudentLocation?limit=100&order=-updatedAt"
        case .postSession: return Endpoints.baseURL + "/session"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
