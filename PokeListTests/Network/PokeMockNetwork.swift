//
//  PokeMockNetwork.swift
//  PokeListTests
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import Foundation
@testable import PokeList

class PokeMockNetwork: PokeNetworkProtocol {
    
    var networkResponse: TestNetworkResponse
    
    typealias PokeDataHandler = (Result<[PokemonData], Error>) -> Void
    typealias PokeInfoHandler = (Result<PokemonInfo, Error>) -> Void
    
    init(networkResponse: TestNetworkResponse) {
        self.networkResponse = networkResponse
    }
    
    func getPokeData(completion: @escaping PokeDataHandler) {
        switch networkResponse {
        case .success(let data):
            let response = data as! [PokemonData]
            completion(.success(response))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func getPokeInfo(url: String, completion: @escaping PokeInfoHandler) {
        switch networkResponse {
        case .success(let data):
            let response = data as! PokemonInfo
            completion(.success(response))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
