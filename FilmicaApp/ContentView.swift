//
//  ContentView.swift
//  FilmicaApp
//
//  Created by Cristian Espes on 22/03/2020.
//  Copyright © 2020 Cristian Espes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var filmsData: FilmsData
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ListFilmView()
                .tabItem {
                    Image(systemName: "film")
                    Text("Películas")
                }
                .tag(0)
            FavoritesView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favoritas")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FilmsData())
    }
}
