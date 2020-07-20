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
    case getMyLocation(String)
    case postSession
    case getPublicUserData(String)
    case postStudentLocation
    case putStudentLocation(String)
    
    var stringValue: String {
        switch self {
        case .getStudentLocation: return Endpoints.baseURL + "/StudentLocation?limit=100&order=-updatedAt"
        case .getMyLocation(let key): return Endpoints.baseURL + "/StudentLocation?uniqueKey=\(key)"
        case .postSession: return Endpoints.baseURL + "/session"
        case .getPublicUserData(let userId): return Endpoints.baseURL + "/users/" + userId
        case .postStudentLocation: return Endpoints.baseURL + "/StudentLocation"
        case .putStudentLocation(let objectId): return Endpoints.baseURL + "/StudentLocation/\(objectId)"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
