//
//  LoginModifiers.swift
//  OnTheMap
//
//  Created by Renan Maganha on 23/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct LoginButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading, 15)
            .foregroundColor(.white)
            .frame(width: 300, height: 30)
            .background(Color(#colorLiteral(red: 0.3111993667, green: 0.6907969998, blue: 1, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 5)
            .shadow(color: Color.white.opacity(0.2), radius: 5, x: -2, y: -5)
    }
}
