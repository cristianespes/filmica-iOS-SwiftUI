//
//  FavoritesView.swift
//  FilmicaApp
//
//  Created by Cristian Espes on 22/03/2020.
//  Copyright © 2020 Cristian Espes. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var filmsData: FilmsData
    
    var body: some View {
        NavigationView {
            if filmsData.films.filter({ $0.isFavorite }).isEmpty {
                Text("No tiene películas favoritas")
                    .foregroundColor(Color.gray)
                    .padding()
                    .navigationBarTitle("Favoritas")
            } else {
                List {
                    ForEach(filmsData.films.filter({$0.isFavorite})) { film in
                        NavigationLink(destination: DetailFilmView(film: film).navigationBarTitle("\(film.title)", displayMode: .inline)) {
                            FilmRowView(film: film)
                        }
                    }
                    .onDelete(perform: deleteFavorite)
                }
                .navigationBarTitle("Favoritas")
            }
        }
    }
    
    private func deleteFavorite(offset: IndexSet) {
        if let first = offset.first {
            filmsData.films[first].isFavorite.toggle()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FilmsData())
    }
}
