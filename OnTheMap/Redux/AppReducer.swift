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
            }
            
            return Reducer.sync { state in
                state.locations = mapService.fetchStudentLocation()
                state.currentScene = mapService.currentScene
            }
        }
    }
    
    private static func handleLoginActions(_ action: LoginAction, mapService: MapService) {
        switch action {
        case .signIn:
            mapService.changeScene(scene: .mapService)
        default:
            break
        }
        
    }
}
