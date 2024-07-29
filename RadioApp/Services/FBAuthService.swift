//
//  FBAuthService.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation
import FirebaseAuth

import SwiftUI


struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

final class FBAuthService {
    static let shared = FBAuthService()
    private init() {}
    var currentUser : User?
    
    
    func signIn (email: String, password: String ) async throws -> Bool {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentUser = result.user
            return true
        } catch {
            print("wrong email or password")
        }
        return false
    }
    
    func getAuthenticationUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
//    func signUp(email: String, password: String) async  throws -> AuthDataResultModel {
//        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
//        return AuthDataResultModel(user: authDataResult.user)
//     }
    func signUp(email: String, password: String) async  throws -> Bool {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentUser = result.user
            return true
        } catch {
            print("cant create user")
        }
        return false
     }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    
}

