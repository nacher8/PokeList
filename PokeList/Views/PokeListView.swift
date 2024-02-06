//
//  PokeListView.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import SwiftUI

struct PokeListView: View {
    @ObservedObject var viewModel: PokeViewModel
    @State var showInfo = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.filteredPokemon, id: \.id) { pokemon in
                            PokeRow(pokemonData: pokemon)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.pokeData = pokemon
                                    viewModel.showInfo.toggle()
                                }
                        }
                    }
                }
                .searchable(text: $viewModel.searchText)
                .environmentObject(viewModel)
                .navigationTitle("Pokedex")
            }
            
            if viewModel.showInfo {
                PokeInfoView(viewModel: viewModel)
            }
            
            if viewModel.filteredPokemon.isEmpty {
                Image("pokeball")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
        .onAppear {
            viewModel.showInfo = false
        }
    }
}
