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
