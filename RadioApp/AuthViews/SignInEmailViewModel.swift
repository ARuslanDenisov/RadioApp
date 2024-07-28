//
//  SignInEmailViewModel.swift
//  RadioApp
//
//  Created by Юрий on 28.07.2024.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print(returnedUserData)
            } catch {
                print(error)
            }
        }
       
    }
}

