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
    @State var showInformationPostingView = false
    
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
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.store.send(.loginActions(.logOut))
                    }, label: {
                        Image("logout")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                            .frame(width: 44, height: 44)
                    }),
                    trailing:
                    HStack(spacing: 16) {
                        Button(action: {
                            self.store.send(.reload)
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .frame(width: 44, height: 44)
                        })
                        
                        Button(action: {
                            self.showInformationPostingView.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .frame(width: 44, height: 44)
                        })
                            .sheet(isPresented: $showInformationPostingView) { InformationPostingView() }
                    }
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
