//
//  ListView.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import Combine

struct ListView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    var body: some View {
        List(store.state.locations.indices, id: \.self) { index in
            ListCell(studentLocation: self.store.state.locations[index])
        }
        .onAppear{
            self.store.send(.reload)
        }
    }
}

struct ListCell: View {
    var studentLocation: StudentLocation
    
    var body: some View {
        HStack {
            Image(systemName: "pin.fill")
                .foregroundColor(.red)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(studentLocation.firstName) \(studentLocation.lastName)")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(studentLocation.mediaURL)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

            }
        }
    }
}
