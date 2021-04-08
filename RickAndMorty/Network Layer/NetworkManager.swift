//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation
import RxSwift
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func getAllCharacters() {
        AF.request(Endpoint.characters).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(CharactersWithInfo.self, from: data)
                print(characters)
            } catch let error {
                print(error)
            }
        }
    }
}
