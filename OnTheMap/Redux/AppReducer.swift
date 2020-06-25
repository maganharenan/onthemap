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
        let clientService: ClientService = MockClientService()
        
        return Reducer { state, action in
            switch action {
            case .reload:
                break
            case .loginActions(let action):
                handleLoginActions(action, mapService: mapService, clientService: clientService)
            }
            
            return Reducer.sync { state in
                state.locations = mapService.fetchStudentLocation()
                state.currentScene = mapService.currentScene
            }
        }
    }
    
    private static func handleLoginActions(_ action: LoginAction, mapService: MapService, clientService: ClientService) {
        switch action {
        case let .signIn(username, password):
            clientService.postSession(username: username, password: password) { (response, error) in
                if let response = response {
                    print(response)
                } else {
                    print(error!)
                }
            }
            mapService.changeScene(scene: .mapService)
        case .signUp:
            break
        case .logOut:
            mapService.changeScene(scene: .login)
        }
        
    }
}
