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


