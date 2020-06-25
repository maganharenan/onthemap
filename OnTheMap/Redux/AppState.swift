//
//  AppState.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import MapKit

struct AppState {
    var currentScene: AppScenes = .login
    
    ///Auth
    var registered = false
    var key = ""
    var id = ""
    var expiration = ""
    
    var locations = [StudentLocation]()
}
