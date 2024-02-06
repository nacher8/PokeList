//
//  ContentView.swift
//  PokeList
//
//  Created by IGNACIO HERNAIZ IZQUIERDO on 6/2/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PokeViewModel()
    var body: some View {
        NavigationStack {
            TabView {
                PokeListView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                PokeFavView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "star.fill")
                    }
            }
        }
        .onAppear {
            viewModel.getPokeData()
        }
    }
}

#Preview {
    ContentView()
}
