//
//  PokeNetwork.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import Foundation

public class PokeNetwork: PokeNetworkProtocol {
    
    func getPokeData(completion: @escaping PokeDataHandler) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decode = JSONDecoder()
                let pokemonList = try decode.decode(Pokemon.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(pokemonList.results))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    func getPokeInfo(url: String, completion: @escaping PokeInfoHandler) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decode = JSONDecoder()
                let pokemonInfo = try decode.decode(PokemonInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(pokemonInfo))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
