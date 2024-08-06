import Foundation
import FirebaseFirestore

struct StationModel: Identifiable, Codable {
    let id: String
    let name: String
    let favicon: String
    let streamUrl: String
    let tags: String
    let language: String
    let countryCode: String
    var votes: Int
    

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
    
    init() {
        self.id = ""
        self.name = ""
        self.favicon = ""
        self.streamUrl = ""
        self.tags = ""
        self.language = ""
        self.countryCode = ""
        self.votes = 0
    }

    var representation: [String: Any] {
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

extension StationModel {
    static func sampleData() -> [StationModel] {
        return [
            StationModel(id: "1", name: "POP", favicon: "", streamUrl: "", tags: "Radio Record", language: "", countryCode: "", votes: 315),
            StationModel(id: "2", name: "16bit", favicon: "", streamUrl: "", tags: "Radio Gameplay", language: "", countryCode: "", votes: 240),
            StationModel(id: "3", name: "Punk", favicon: "", streamUrl: "", tags: "Russian Punk rock", language: "", countryCode: "", votes: 200),
            StationModel(id: "4", name: "Dj remix", favicon: "", streamUrl: "", tags: "!REMIX! ", language: "", countryCode: "", votes: 54),
            StationModel(id: "5", name: "Adult", favicon: "", streamUrl: "", tags: "RUSSIAN WAVE", language: "", countryCode: "", votes: 315),
            StationModel(id: "6", name: "Etnic", favicon: "", streamUrl: "", tags: "beufm.kz", language: "", countryCode: "", votes: 74)
        ]
    }
}
