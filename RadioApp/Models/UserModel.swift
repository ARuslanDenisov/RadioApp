//
//  UserModel.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation
import FirebaseAuth

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
