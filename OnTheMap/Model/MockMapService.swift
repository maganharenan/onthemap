//
//  MockMapService.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import SwiftUI

class MockMapService: MapService {
    var currentScene: AppScenes = .login
    
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
    
    func fetchStudentLocation() -> [StudentLocation] {
        var studentLocation = [StudentLocation]()
        let task = DispatchGroup()
        
        task.enter()
        getStudentLocation { (response, error) in
            if let response = response {
                studentLocation = response.results
                task.leave()
            } else {
                print(error!)
                task.leave()
            }
        }
        task.wait()

        return studentLocation
    }
    
    func changeScene(scene: AppScenes) {
        currentScene = scene
    }
}
