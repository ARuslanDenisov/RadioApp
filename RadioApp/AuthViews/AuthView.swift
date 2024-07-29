//
//  AuthView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct AuthView: View {
    var signIn: Bool = true
    var body: some View {
        ZStack {
            Image("bgAuth")
                .resizableToFill()
                .ignoresSafeArea()
                
            VStack {
                HStack {
                    Image("appLogo")
                        .resizableToFit()
                        .frame(width: 58, height: 58)
                    Spacer()
                }
                VStack {
                    Text(signIn ? "Sign in" : "Sign up")
                        .foregroundStyle(.white)
                        .font(.custom(Font.light, size: 50))
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
