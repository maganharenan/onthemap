//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Renan Maganha on 21/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import MapKit

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

func getStudentLocation(completion: @escaping (StudentResults?, Error?) -> Void) {
    let task = URLSession.shared.dataTask(with: Endpoints.getStudentLocation.url) { (data, response, error) in
        guard let data = data else {
            completion(nil, error)
            return
        }
        
        let decoder = JSONDecoder()
  
        do {
            let objectResponse = try decoder.decode(StudentResults.self, from: data)
            completion(objectResponse, nil)
        } catch {
            completion(nil, error)
        }
    }
    task.resume()
}

func handleStudentLocation(studentLocation: StudentResults?, error: Error?) -> [StudentLocation] {
    if let studentLocation = studentLocation {
        return studentLocation.results
    } else {
        print(error!)
        return []
    }
}


