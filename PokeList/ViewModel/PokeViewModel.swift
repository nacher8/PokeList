//
//  PokeViewModel.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import Foundation

final class PokeViewModel: ObservableObject {
    
    @Published var pokeList: [PokemonData] = []
    @Published var pokeFavList: [PokemonData] = []
    @Published var pokeData: PokemonData?
    @Published var pokeInfo: PokemonInfo?
    @Published var searchText = ""
    @Published var searchFavText = ""
    @Published var showInfo: Bool = false
    
    var filteredPokemon: [PokemonData] {
        return searchText == "" ? pokeList : pokeList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    var filteredFavPokemon: [PokemonData] {
        return searchFavText == "" ? pokeFavList : pokeFavList.filter {
            $0.name.contains(searchFavText.lowercased())
        }
    }
    
    let network: PokeNetworkProtocol?
    
    init(network: PokeNetworkProtocol? = PokeNetwork()) {
        self.network = network
        getFavPokemon()
    }
    
    // Get the Pokemons
    func getPokeData() {
        network?.getPokeData(completion: { result in
            switch result {
            case .success(let pokeData):
                self.pokeList = pokeData
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // Get info specific Pokemon
    func getPokeInfo(url: String) {
        network?.getPokeInfo(url: url, completion: { result in
            switch result {
            case .success(let pokeInfo):
                DispatchQueue.main.async {
                    self.pokeInfo = pokeInfo
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // Check if Pokemon is in the favorite list
    func isFavPokemon() -> Bool {
        if pokeFavList.first(where: { $0.id == pokeData?.id}) != nil {
            return true
        }
        return false
    }
    
    // Get favorite list Pokemon from UserDefaults
    private func getFavPokemon() {
        guard let pokeFav = UserDefaults.standard.data(forKey: "pokeFav") else {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(pokeFavList)
                UserDefaults.standard.set(data, forKey: "pokeFav")
            } catch let error {
                print(error.localizedDescription)
            }
            return
        }
        do {
            let decoder = JSONDecoder()
            pokeFavList = try decoder.decode([PokemonData].self, from: pokeFav)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Append Pokemon to favorite list
    func appendPokemonFav() {
        guard let pokeData = pokeData else {
            return
        }
        pokeFavList.append(pokeData)
        saveFavData()
    }
    
    // Remove Pokemon to favorite list
    func removePokemonFav() {
        if let indexPokemon = pokeFavList.firstIndex(where: { $0.id == pokeData?.id}) {
            pokeFavList.remove(at: indexPokemon)
            saveFavData()
        }
    }
    
    // Save info favorite list in UserDefaults
    private func saveFavData() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pokeFavList)
            UserDefaults.standard.set(data, forKey: "pokeFav")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
