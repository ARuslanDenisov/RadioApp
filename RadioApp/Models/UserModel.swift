//
//  UserModel.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserModel : Identifiable, Codable {
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var photoUrl: String = ""
    var favorites: [StationModel] = []
    
    init(id: String, name: String, email: String, photoUrl: String, favorites: [StationModel]) {
        self.id = id
        self.name = name
        self.email = email
        self.photoUrl = photoUrl
        self.favorites = favorites
    }
    init(user: User) {
        self.id = user.uid
        if let email = user.email {
            self.email = email
        }
        if let photo = user.photoURL?.absoluteString {
            photoUrl = photo
        }
    }
    init () { }
    

}

extension UserModel {
    var representation: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["email"] = self.email
        dict["photoUrl"] = self.photoUrl
        return dict
    }
    
    
    init?(qdSnap: DocumentSnapshot) async throws {
        guard let data = qdSnap.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let email = data["email"] as? String,
              let photoUrl = data["photoUrl"] as? String else { return nil }
        self.id = id
        self.name = name
        self.email = email
        self.photoUrl = photoUrl
        self.favorites = try await FBFirestoreService.shared.getUserFavorites(userId: id)
    }
}
