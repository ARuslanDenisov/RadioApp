//
//  SignInEmailView.swift
//  RadioApp
//
//  Created by Юрий on 28.07.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Your email", text: $viewModel.email)
                .padding()
                .background(.background)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.red)
                )
            
            SecureField("Your password", text: $viewModel.password)
                .padding()
                .background(.background)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.red)
                )
            
            Button {
                viewModel.signIn()
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.mint)
            }
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    AuthView()
}
