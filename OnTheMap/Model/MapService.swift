//
//  MapService.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import MapKit

protocol MapService {
    var currentScene: AppScenes { get }
    func fetchStudentLocation() -> [StudentLocation]
    func changeScene(scene: AppScenes)
}
