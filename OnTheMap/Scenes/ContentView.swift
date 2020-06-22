//
//  ContentView.swift
//  OnTheMap
//
//  Created by Renan Maganha on 21/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    var body: some View {
        TabView {
            ListView()
            .tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }
            MapView()
            .tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
