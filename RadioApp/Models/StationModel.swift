//
//  StationModel.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation
import FirebaseFirestore

struct StationModel : Identifiable, Codable {
    let id: String
    let name: String
    let favicon: String
    let streamUrl: String
    let tags: String
    let language: String
    let countryCode: String
    let votes: Int
    
    init(id: String, name: String, favicon: String, streamUrl: String, tags: String, language: String, countryCode: String, votes: Int) {
        self.id = id
        self.name = name
        self.favicon = favicon
        self.streamUrl = streamUrl
        self.tags = tags
        self.language = language
        self.countryCode = countryCode
        self.votes = votes
    }
    init () {
        self.id = ""
        self.name = ""
        self.favicon = ""
        self.streamUrl = ""
        self.tags = ""
        self.language = ""
        self.countryCode = ""
        self.votes = 0
    }
}

extension StationModel {
    var representation : [String: Any] {
        var dict = [String: Any]()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["favicon"] = self.favicon
        dict["streamUrl"] = self.streamUrl
        dict["tags"] = self.tags
        dict["language"] = self.language
        dict["countryCode"] = self.countryCode
        dict["votes"] = self.votes
        return dict
    }
    
    init?(qdSnap: QueryDocumentSnapshot) {
        let data = qdSnap.data()
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let favicon = data["favicon"] as? String,
              let streamUrl = data["streamUrl"] as? String,
              let tags = data["tags"] as? String,
              let language = data["language"] as? String,
              let countryCode = data["countryCode"] as? String,
              let votes = data["votes"] as? Int else { return nil }
        self.id = id
        self.name = name
        self.favicon = favicon
        self.streamUrl = streamUrl
        self.tags = tags
        self.language = language
        self.countryCode = countryCode
        self.votes = votes

    }
}
