//
//  FavoritesView.swift
//  FilmicaApp
//
//  Created by Cristian Espes on 22/03/2020.
//  Copyright © 2020 Cristian Espes. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var filmsData: FilmsData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filmsData.films.filter({$0.isFavorite})) { film in
                    NavigationLink(destination: DetailFilmView(film: film).navigationBarTitle("\(film.title)", displayMode: .inline)) {
                        FilmRowView(film: film)
                    }
                }
            }
            .navigationBarTitle("Favoritas")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
