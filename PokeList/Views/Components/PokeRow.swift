//
//  PokeRaw.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import SwiftUI

struct PokeRow: View {
    @EnvironmentObject var viewModel: PokeViewModel
    let pokemonData: PokemonData
    
    var body: some View {
        HStack {
            AsyncImage(url: pokemonData.imageUrl) { image in
                image.resizable()
            } placeholder: {
                Image("pokeball")
                    .resizable()
                    .padding()
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 75)
            
            Text(pokemonData.name.capitalized)
                .font(.title)
                .fontWeight(.medium)
            
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

