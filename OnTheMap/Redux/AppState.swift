//
//  AppState.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import MapKit

struct AppState {
    var currentScene: AppScenes = .login
    var alertMessage = ""
    var showAlert: Bool = false
    
    ///Auth
    var registered = false
    var key = ""
    var id = ""
    var expiration = ""
    
    var locations = [StudentLocation]()
    
    var firstName = ""
    var lastName = ""
    var nickname = ""
    
    var isAlreadyPosted = false
    var objectId = ""
}
