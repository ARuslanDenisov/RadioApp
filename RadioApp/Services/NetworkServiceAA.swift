//
//  NetworkServiceAA.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation
import SwiftyJSON

class NetworkServiceAA {
    static let shared = NetworkServiceAA() ; private init() {}
    
    //MARK: Get Stations by URL
    func getStations (url: URL) async throws -> [StationModel] {
        do {
            let responce = try await URLSession.shared.data(from: url)
            if let json = try? JSON(data: responce.0) {
                var stations: [StationModel] = []
                for station in json.arrayValue {
                    stations.append(StationModel(id: station["stationuuid"].stringValue, name: station["name"].stringValue, favicon: station["favicon"].stringValue, streamUrl: station["url"].stringValue, tags: station["tags"].stringValue, language: station["language"].stringValue, countryCode: station["languagecodes"].stringValue, votes: station["votes"].intValue))
                }
                return stations
            }
        } catch {
            throw NetworkError.badResponse
        }
        return []
    }
    
    //MARK: Get Station be url
    func getStations (UUID: String) async throws -> StationModel {
        guard let url = URLManager.shared.createURLUUID(uuid: UUID) else {
            throw NetworkError.badURL
        }
        do {
            let responce = try await URLSession.shared.data(from: url)
            if let station = try? JSON(data: responce.0) {
                return StationModel(id: station["stationuuid"].stringValue, name: station["name"].stringValue, favicon: station["favicon"].stringValue, streamUrl: station["url"].stringValue, tags: station["tags"].stringValue, language: station["language"].stringValue, countryCode: station["languagecodes"].stringValue, votes: station["votes"].intValue)
            }
        } catch {
            throw NetworkError.badResponse
        }
        return StationModel()
    }
    
    //MARK: Get all stations
    func getAllStations(numberLimit: Int) async throws -> [StationModel] {
        guard let url = URLManager.shared.createURLAll(limit: numberLimit) else {
            throw NetworkError.badURL
        }
        return try await getStations(url: url)
    }
    
    //MARK: Get Stations by UUIDs
    func getStationsByUUIDs(UUDS: [String] ) async throws -> [StationModel] {
        guard let url = URLManager.shared.createURLUUIDS(uuids: UUDS) else {
            throw NetworkError.badURL
        }
        return try await getStations(url: url)
    }
    
    //MARK: Get Popular Stations
    func getPopularStations(numberLimit: Int) async throws -> [StationModel] {
        guard let url = URLManager.shared.createURLPopular(limit: numberLimit) else {
            throw NetworkError.badURL
        }
        return try await getStations(url: url)
    }
    
    //MARK: Search Stations by name in popular
    func searchStations(name: String ,numberLimit: Int) async throws -> [StationModel] {
        guard let url = URLManager.shared.createURLSearch(name, numberLimit: numberLimit) else {
            throw NetworkError.badURL
        }
        return try await getStations(url: url)
    }
    
    //MARK: Get Stations by tag
    func getStationsByTag(tag: String, numberLimit: Int) async throws -> [StationModel] {
        guard let url = URLManager.shared.createURLTags(name: tag, limit: numberLimit) else {
            throw NetworkError.badURL
        }
        return try await getStations(url: url)
    }
    
    //MARK: Get Stations by language
    func getStationsByTag(lang: String, numberLimit: Int) async throws -> [StationModel] {
        guard let url = URLManager.shared.createURLLanguage(name: lang, limit: numberLimit) else {
            throw NetworkError.badURL
        }
        return try await getStations(url: url)
    }
    
    //MARK: Get Stations by country
    func getStationsByTag(country: String, numberLimit: Int) async throws -> [StationModel] {
        guard let url = URLManager.shared.createURLCountry(name: country, limit: numberLimit ) else {
            throw NetworkError.badURL
        }
        return try await getStations(url: url)
    }
    //MARK: Get stations by tag
    func getStationsByTag (setup: SearchType, value: String, numberLimit: Int) async throws -> [StationModel] {
        switch setup {
        case .country : return try await getStationsByTag(country: value, numberLimit: numberLimit)
        case .language : return try await getStationsByTag(lang: value, numberLimit: numberLimit)
        case .tags : return try await getStationsByTag(tag: value, numberLimit: numberLimit)
        }
    }
    
    func searchStationWithTag (search: String, setup: SearchType, value: String, numberLimit: Int) async throws -> [StationModel] {
        guard let url = URLManager.shared.createURLSearchForTag(search, numberLimit: numberLimit, setup: setup, tag: value) else {
            throw NetworkError.badURL
        }
        return try await getStations(url: url)
        
    }
    
    func voteForStation( station: StationModel ) async throws {
        guard let url = URL(string: "http://all.api.radio-browser.info/json/vote/\(station.id)") else {
            throw NetworkError.badURL
        }
        let responce = try await URLSession.shared.data(from: url)
    }
    
    
}

enum NetworkError: Error {
    case badURL
    case badData
    case badResponse
    case invalidDecoding
}

