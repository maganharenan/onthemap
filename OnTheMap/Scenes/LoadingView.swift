//
//  LoadingView.swift
//  OnTheMap
//
//  Created by Renan Maganha on 28/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(fileName: "profile")
                .frame(width: 150, height: 150)
            LottieView(fileName: "locationPin")
                .frame(width: 100, height: 100)
                .offset(y: -40)
            
            Text("Authenticating the user")
                .foregroundColor(.primary)
                .font(.system(size: 17, weight: .thin, design: .rounded))
                .offset(y: -40)

        }
        .frame(width: 250, height: 300)
        .background(Color(.systemGray6).opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 0)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
