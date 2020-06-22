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
    func fetchStudentLocation() -> [StudentLocation]
}
