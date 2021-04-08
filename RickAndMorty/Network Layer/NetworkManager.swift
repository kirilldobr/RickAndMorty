//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation
import RxSwift
import Alamofire


import RxSwift
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func getCharacters(urlString: String?) -> Observable<CharactersWithInfo> {
        let configuration = URLSessionConfiguration.default
       // configuration.urlCache = nil
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        
        guard let urlString = urlString,
              let url = URL(string: urlString)
        else {
            return Observable.empty()
        }
        
        return Observable.create{ observer in
            let request = sessionManager.request(url)
                .responseJSON { dataResponse in
                    if let error = dataResponse.error {
                        observer.onError(error)
                    } else if let data = dataResponse.data {
                        do {
                            observer.onNext(try JSONDecoder().decode(CharactersWithInfo.self, from: data))
                            observer.onCompleted()
                        } catch (let error) {
                            observer.onError(error)
                        }
                    } else {
                        observer.onCompleted()
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
        .timeout(.seconds(2), scheduler: MainScheduler.instance)
        .retry()
        .observeOn(MainScheduler.instance)
    }
}
