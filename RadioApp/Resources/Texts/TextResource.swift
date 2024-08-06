//
//  TextResourse.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import Foundation

enum SearchType: String, CaseIterable {
    case tags
    case language
    case country
}

enum RadioTags: String, CaseIterable {
    case electro
    case rock
    case house
    case mashup
    case pop
    case russiandance
    case techno
    case best
    case black
    case bosna
    case florida
    case folk
    case freeform
    case freestyle
    case funk
    case gaming
    case gig
}

enum Country: String, CaseIterable {
    case Uganda
    case Ukraine
    case Serbia
    case Norway
    case Russia = "The Russian Federation"
    case Rwanda
    case Japan
    case Island
}

enum Languages: String, CaseIterable {
    case english
    case russian
    case german
    case espanish
    case french
    case indonesian
}
