//
//  Character.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let aliveStatus: AliveStatus
    let imageURL: String
    let species: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case aliveStatus = "status"
        case imageURL = "image"
        case species
    }
}

struct CharactersWithInfo: Codable {
    let info: Info
    let characters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
}

struct Info: Codable {
    let pages: Int
    let nextPageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case pages
        case nextPageURL = "next"
    }
}
