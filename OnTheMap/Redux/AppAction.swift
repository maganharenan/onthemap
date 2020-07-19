//
//  AppAction.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import MapKit

enum AppAction {
    case reload
    case sessionActions(SessionAction)
    case dismissAlert
    case parseAPIActions(ParseAPIActions)
}

enum SessionAction {
    case signIn(String, String)
    case signUp
    case logOut
}

enum ParseAPIActions {
    case newLocation
    case postStudentLocation(String, CLLocationDegrees, CLLocationDegrees, String)
}
