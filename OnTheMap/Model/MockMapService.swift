//
//  MockMapService.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

class MockMapService: MapService {

    func fetchStudentLocation() -> [StudentLocation] {
        var studentLocation = [StudentLocation]()
        let task = DispatchGroup()
        
        task.enter()
        getStudentLocation { (response, error) in
            if let response = response {
                studentLocation = response.results
                task.leave()
                print("task")
            } else {
                print(error!)
                task.leave()
            }
        }
        task.wait()
        
        print("acabou")
        return studentLocation
    }
}
