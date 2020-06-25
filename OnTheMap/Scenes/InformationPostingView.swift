//
//  InformationPostingView.swift
//  OnTheMap
//
//  Created by Nuxen on 24/06/20.
//  Copyright © 2020 renan maganha. All rights reserved.
//

import SwiftUI

struct InformationPostingView: View {
    @State var location = ""
    @State var link = ""
    var body: some View {
        NavigationView {
            VStack {
                Image("earth")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .padding(.top)
                    .padding(.bottom, 70)
                
                
                TextField("Location", text: $location)
                    .frame(width: 300)
                
                Rectangle()
                    .frame(width: 300, height: 1.2)
                    .foregroundColor(Color(#colorLiteral(red: 0.3111993667, green: 0.6907969998, blue: 1, alpha: 1)))
                    .padding(.top, -10)
                
                TextField("Link", text: $link)
                    .frame(width: 300)
                
                Rectangle()
                    .frame(width: 300, height: 1.2)
                    .foregroundColor(Color(#colorLiteral(red: 0.3111993667, green: 0.6907969998, blue: 1, alpha: 1)))
                    .padding(.top, -10)
                    
                Spacer()
                
            }
            .navigationBarTitle("Add Location", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    
                }, label: {
                    Text("CANCEL")
                })
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct InformationPostingView_Previews: PreviewProvider {
    static var previews: some View {
        InformationPostingView()
    }
}
