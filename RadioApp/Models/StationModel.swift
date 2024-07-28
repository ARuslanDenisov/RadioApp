//
//  StationModel.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation

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
