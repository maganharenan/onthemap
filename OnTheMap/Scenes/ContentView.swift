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
        VStack {
            if store.state.currentScene == .mapService {
                NavigationView {
                TabView {
                    MapView()
                        .tabItem {
                            Image(systemName: "mappin.and.ellipse")
                            Text("Map")
                    }
                    ListView()
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("List")
                    }
                }
                .navigationBarItems(leading:
                    Button(action: {
                    
                    }, label: {
                        Text("LOGOUT")
                    })
                )
                    .navigationBarTitle("On the Map", displayMode: .inline)
            }
                .navigationViewStyle(StackNavigationViewStyle())
            } else {
                LoginView()
            }
        }
    }
}
