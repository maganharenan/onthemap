//
//  AppAction.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

enum AppAction {
    case reload
    case loginActions(LoginAction)
    case changeScene(AppScenes)
}

enum LoginAction {
    case signIn(String, String)
    case signUp
    case logOut
}
