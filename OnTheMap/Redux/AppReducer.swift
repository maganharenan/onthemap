//
//  AppReducer.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import SwiftUI

extension Reducer where State == AppState, Action == AppAction {
    static func appReducer() -> Reducer {
        let mapService: MapService = MockMapService()
        
        return Reducer { state, action in
            switch action {
            case .reload:
                break
            case .sessionActions(let action):
                handleLoginActions(action, mapService: mapService)
            case .dismissAlert:
                mapService.dismissAlert()
            case .parseAPIActions(let action):
                handleParseAPIActions(action, mapService: mapService)
            }
            
            return Reducer.sync { state in
                state.currentScene      = mapService.currentScene
                state.alertMessage      = mapService.alertMessage
                state.showAlert         = mapService.showAlert
                state.locations         = mapService.fetchStudentLocation()
                state.registered        = mapService.registered!
                state.key               = mapService.key!
                state.id                = mapService.id!
                state.expiration        = mapService.expiration!
                state.firstName         = mapService.firstName
                state.lastName          = mapService.lastName
                state.nickname          = mapService.nickname
                state.isAlreadyPosted   = mapService.isAlreadyPosted
                state.objectId          = mapService.objectId
            }
        }
    }
    
    private static func handleLoginActions(_ action: SessionAction, mapService: MapService) {
        switch action {
        case let .signIn(username, password):
            mapService.handlePostSession(username: username.lowercased(), password: password)
        case .signUp:
            UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
        case .logOut:
            mapService.handleDeleteSession()
        }
    }
    
    private static func handleParseAPIActions(_ action: ParseAPIActions, mapService: MapService) {
        switch action {
        case let .postStudentLocation(mapString, latitude, longitude, mediaURL):
            mapService.handlePostStudentLocation(mapString: mapString, latitude: latitude, Longitude: longitude, mediaURL: mediaURL)
        case .newLocation:
            mapService.searchForLocationByUniqueKey()
        case let .putStudentLocation(mapString, latitude, longitude, mediaURL):
            mapService.handlePutStudentLocation(mapString: mapString, latitude: latitude, Longitude: longitude, mediaURL: mediaURL)
        }
    }
}
