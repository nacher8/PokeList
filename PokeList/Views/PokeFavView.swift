//
//  PokeFavView.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import SwiftUI

struct PokeFavView: View {
    @ObservedObject var viewModel: PokeViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.filteredFavPokemon, id: \.id) { pokemon in
                            PokeRow(pokemonData: pokemon)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.pokeData = pokemon
                                    viewModel.showInfo.toggle()
                                }
                        }
                    }
                }
                .searchable(text: $viewModel.searchFavText)
                .environmentObject(viewModel)
                .navigationTitle("Pokedex Favorite")
            }
            
            if viewModel.filteredFavPokemon.isEmpty {
                Image("pokeball")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            
            if viewModel.showInfo {
                PokeInfoView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.showInfo = false
        }
    }
}
