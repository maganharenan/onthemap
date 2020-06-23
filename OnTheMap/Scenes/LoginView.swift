//
//  LoginView.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    @State var email = ""
    @State var emailError = true
    @State var password = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("GradientColorTop"), Color("GradientColorBottom")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 5) {
                
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 100, weight: .thin))
                    .padding(.vertical, 30)
                    .padding(.top, 70)
                
                Text("ON THE MAP")
                    .font(.system(size: 20, weight: .thin, design: .rounded))
                    .tracking(15)
                    .padding(.leading, 15)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .padding(.top, 40)
                
                if emailError { Text("Enter a valid email adress!").foregroundColor(.red).font(.footnote) }
                
                TextField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                Button(action: {
                    self.store.send(.loginActions(.signIn))
                }, label: {
                    Text("LOGIN")
                        .tracking(7)
                        .padding(.leading, 15)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 30)
                        .background(Color(#colorLiteral(red: 0.3111993667, green: 0.6907969998, blue: 1, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 7)
                        .shadow(color: Color.white.opacity(0.2), radius: 5, x: -5, y: -7)
                })
                    .padding(.top, 30)
                
                Spacer()
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environment(\.colorScheme, .dark)
    }
}
