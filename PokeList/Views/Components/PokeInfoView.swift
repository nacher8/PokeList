//
//  PokeInfoView.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import SwiftUI

struct PokeInfoView: View {
    @ObservedObject var viewModel: PokeViewModel
    @State private var animationAmount = 1.0
    
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.8)
                .onTapGesture {
                    close()
                }
            
            VStack(alignment: .center) {
                AsyncImage(url: viewModel.pokeData?.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    Image("pokeball")
                        .resizable()
                        .padding()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(viewModel.isFavPokemon() ? .yellow : .gray)
                    .onTapGesture {
                        if viewModel.isFavPokemon() {
                            viewModel.removePokemonFav()
                        } else {
                            viewModel.appendPokemonFav()
                        }
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    InfoPokemonRow(title: "ID: ", info: viewModel.pokeInfo?.id.description ?? "")
                    InfoPokemonRow(title: "NAME: ", info: viewModel.pokeInfo?.name.capitalized ?? "")
                    InfoPokemonRow(title: "HEIGHT: ", info: viewModel.pokeInfo?.height.description ?? "0")
                    InfoPokemonRow(title: "WEIGHT: ", info: viewModel.pokeInfo?.weight.description ?? "0")
                }
                .padding()
            }
            .padding()
            .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.25)) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.getPokeInfo(url: "https://pokeapi.co/api/v2/pokemon/\(viewModel.pokeData?.id ?? 0)/")
        }
    }
    
    private func close() {
        offset = 1000
        viewModel.showInfo = false
    }
}

struct InfoPokemonRow: View {
    var title: String
    var info: String
    
    init(title: String, info: String) {
        self.title = title
        self.info = info
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(info)
                .font(.title)
                .fontWeight(.light)
        }
    }
}
