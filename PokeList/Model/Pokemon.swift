//
//  Pokemon.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import Foundation
import SwiftUI

struct Pokemon: Decodable {
    var results: [PokemonData]
}

struct PokemonData: Codable, Equatable {
    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }
    var name: String
    var url: String
    var imageUrl: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png")
    }
    var imagePokemon: AsyncImage<Image> {
        AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png"))
    }
    
    static func ==(lhs: PokemonData, rhs: PokemonData) -> Bool {
        return lhs.name == rhs.name
        && lhs.url == rhs.url
    }
    
}

struct PokemonInfo: Codable, Equatable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
    
    static func ==(lhs: PokemonInfo, rhs: PokemonInfo) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.height == rhs.height
        && lhs.weight == rhs.weight
    }
}
