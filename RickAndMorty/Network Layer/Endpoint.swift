//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation

struct Endpoint {
    private static let base = "https://rickandmortyapi.com/api/"
    
    static var character: String {
        return base + "character/"
    }
    
    static func characters(for page: Int) -> String {
        return character + "?page=\(page)"
    }
}
