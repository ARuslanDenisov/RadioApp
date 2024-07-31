//
//  AuthViewModel.swift
//  RadioApp
//
//  Created by Руслан on 29.07.2024.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

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
    
    func signInGoogle() async throws {
        guard let topVC = Utilites.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await FBAuthService.shared.signInWithGoogle(tokens: tokens)
    }
}
