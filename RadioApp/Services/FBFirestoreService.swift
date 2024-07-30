//
//  FBFirestoreService.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation

import Foundation
import FirebaseFirestore

class FBFirestoreService {
    static let shared = FBFirestoreService(); private init () { }
    let db = Firestore.firestore()
    
    var usersRef: CollectionReference { db.collection("users") }
    var favoritesRef: CollectionReference { db.collection("favorites") }
    
    
    // CRUD operations
    
    //create
    func addNewUser (newUser: UserModel) async throws -> Bool {
        do {
            try await usersRef.document(newUser.id).setData(newUser.representation)
            return true
        } catch {
            return false
        }
    }
    
    //read
    
    func getUser (userId: String) async throws -> UserModel {
        let snapshot = try await usersRef.document(userId).getDocument()
        guard var user = try await UserModel(qdSnap: snapshot) else { throw NetworkError.badData }
        user.favorites = try await getUserFavorites(userId: userId)
        return user
    }
    
    func getUserFavorites (userId: String) async throws -> [StationModel] {
        let snapshot = try await favoritesRef.document(userId).collection("favorites").getDocuments()
        let docs = snapshot.documents
        var favorites = [StationModel]()
        for doc in docs { if let station = StationModel(qdSnap: doc) { favorites.append(station) } }
        return favorites
    }
    
    //update
    
    func updateUser (user: UserModel) async throws {
        do {
            try await usersRef.document(user.id).setData(user.representation)
            try await updateFavorites(user: user)
        } catch {
            throw error
        }
    }
    
    func updateFavorites(user: UserModel ) async throws {
        do {
            try await favoritesRef.document(user.id).delete()
            for station in user.favorites {
                try await favoritesRef.document(user.id).collection("favorites").document("\(station.id)").setData(station.representation)
            }
        } catch {
            throw error
        }
    }
    
    //delete
    
    func deleteUser (user: UserModel) async throws {
        do {
            try await usersRef.document(user.id).delete()
            try await favoritesRef.document(user.id).delete()
        } catch {
            print("problem with delete user")
            throw error
        }
    }
    
    func deleteFavorites (user: UserModel) async throws {
        do {
            try await favoritesRef.document(user.id).delete()
        } catch {
            print("problem with delete favorite")
            throw error
        }
    }
    
    
}
