//
//  URLManager.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation

//по одному айди
//http://all.api.radio-browser.info/json/stations/byuuid/96102c22-0601-11e8-ae97-52543be04c81
//стек через запятую
//http://all.api.radio-browser.info/json/stations/byuuid?uuids=96102c22-0601-11e8-ae97-52543be04c81,566306b4-6f54-4ab6-a238-adcef2b645fd
//популярные
//http://all.api.radio-browser.info/json/stations/topvote/10 popular 10-limits
//поиск
//http://all.api.radio-browser.info/json/stations/search?name=jazz&limit=100
//GET /json/stations/search?tag=rock&codec=mp3&order=country&reverse=true&limit=1000
///stations/bycountry/austria
/////http://all.api.radio-browser.info/json/stations
///
class URLManager {
    
    static let shared = URLManager() ; private init (){}
    
    private let server = "http://all.api.radio-browser.info/json/stations"
    
    //поиск по имени
    func createURLSearch (_ name: String, numberLimit: Int) -> URL? {
        URL(string: server + "/search?name=\(name)&limit=\(numberLimit.description)")
    }
    //получение станции по uuid
    func createURLUUID ( uuid: String) -> URL? {
        URL(string: server + "/byuuid/\(uuid)")
    }
    //получение станций по стеку uuid
    func createURLUUIDS ( uuids: [String]) -> URL? {
        var str = ""
        for i in uuids.indices { str.append(i == 0 ? uuids[i] : ",\(uuids[i])") }
        return URL(string: server + "/byuuid/\(str)")
    }
    //получение стека всех станций
    func createURLAll ( limit: Int) -> URL? {
        URL(string: server + "?limit=\(limit.description)")
    }
    //получение стека популярных станций
    func createURLPopular ( limit: Int) -> URL? {
        URL(string: server + "/topvote/\(limit.description)")
    }
    //получение по тэгу
    func createURLTags (name: String, limit: Int) -> URL? {
        URL(string: server + "/bytag/\(name)?limit=\(limit.description)")
    }
    //получение по языку
    func createURLLanguage (name: String, limit: Int) -> URL? {
        URL(string: server + "/bylanguage/\(name)?limit=\(limit.description)")
    }
    //получение по стране
    func createURLCountry (name: String, limit: Int) -> URL? {
        URL(string: server + "/bycountry/\(name)?limit=\(limit.description)")
    }
    
}

