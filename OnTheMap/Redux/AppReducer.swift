//
//  AppReducer.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

extension Reducer where State == AppState, Action == AppAction {
    static func appReducer() -> Reducer {
        let mapService: MapService = MockMapService()
        
        return Reducer { state, action in
            switch action {
            case .reload:
                break
            case .loginActions(let action):
                handleLoginActions(action, mapService: mapService)
            case .changeScene(let scene):
                break
            }
            
            return Reducer.sync { state in
                state.currentScene  = mapService.currentScene
                state.locations     = mapService.fetchStudentLocation()
                state.registered    = mapService.registered!
                state.key           = mapService.key!
                state.id            = mapService.id!
                state.expiration    = mapService.expiration!
            }
        }
    }
    
    private static func handleLoginActions(_ action: LoginAction, mapService: MapService) {
        switch action {
        case let .signIn(username, password):
            mapService.handlePostSession(username: username.lowercased(), password: password)
        case .signUp:
            break
        case .logOut:
            mapService.deleteSession()
        }
        
    }
}
