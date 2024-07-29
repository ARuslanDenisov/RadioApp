//
//  AuthViewModel.swift
//  RadioApp
//
//  Created by Руслан on 29.07.2024.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var passwordHidden = true
    @Published var signInBool = true
    @Published var userModel: UserModel = UserModel()
    

    func signIn() async -> Bool {
        do {
            var result: Bool = false
            result = try await FBAuthService.shared.signIn(email: email, password: password)
            return result
        } catch {
            print("error")
            return false
        }
    }
    
    func signUp() async -> Bool {
        do {
            var result: Bool = false
            result = try await FBAuthService.shared.signUp(email: email, password: password)
            if let id = FBAuthService.shared.currentUser?.uid {
                userModel = UserModel(id: id,
                                      name: name,
                                      email: email,
                                      photoUrl: "",
                                      favorites: [])
            }
            return result
        } catch {
            print("error")
            return false
        }
        
        
    }

}
