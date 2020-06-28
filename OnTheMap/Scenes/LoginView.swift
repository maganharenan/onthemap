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
    @State var password = ""
    @State var isLoading = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("GradientColorTop"), Color("GradientColorBottom")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                
                Spacer()
                
                Image("logo")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .foregroundColor(Color("LogInLogo"))
                    .padding(.vertical, 30)
                
                Text("ON THE MAP")
                    .font(.system(size: 20, weight: .thin, design: .rounded))
                    .tracking(15)
                    .padding(.leading, 15)
                    .padding(.bottom, 50)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .disabled(isLoading)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .disabled(isLoading)
                
                Button(action: {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                            self.store.send(.loginActions(.signIn(self.email, self.password)))
                        }
                    }
                }, label: {
                    Text("LOGIN")
                        .tracking(7)
                        .modifier(LoginButtonModifier())
                })
                    .padding(.top, 30)
                    .alert(isPresented: .constant(store.state.showAlert)) {
                        Alert(title: Text("Login Failure"), message: Text("\(store.state.alertMessage)"), dismissButton: .default(Text("Ok"), action: {
                            self.isLoading = false
                            self.store.send(.dismissAlert)
                        }))
                    }
                    .disabled(isLoading)
                
                HStack {
                    Text("Don't have and account?")
                    
                    Button(action: {
                        self.store.send(.loginActions(.signUp))
                    }, label: {
                        Text("Sign Up")
                    })
                        .disabled(isLoading)
                }
                .font(.system(size: 13, weight: .thin, design: .rounded))
                
                Spacer()
            }
            
            if isLoading && !store.state.showAlert {
                LoadingView()
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
