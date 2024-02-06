//
//  PokeNetworkProtocol.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import Foundation

protocol PokeNetworkProtocol {
    
    typealias PokeDataHandler = (Result<[PokemonData], Error>) -> Void
    typealias PokeInfoHandler = (Result<PokemonInfo, Error>) -> Void
    
    func getPokeData(completion: @escaping PokeDataHandler)
    func getPokeInfo(url: String, completion: @escaping PokeInfoHandler)
    
}
