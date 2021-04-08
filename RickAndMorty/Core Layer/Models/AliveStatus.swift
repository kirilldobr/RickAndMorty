//
//  AliveStatus.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation

enum AliveStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
