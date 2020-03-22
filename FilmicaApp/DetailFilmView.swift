//
//  DetailFilmView.swift
//  FilmicaApp
//
//  Created by Cristian Espes on 22/03/2020.
//  Copyright © 2020 Cristian Espes. All rights reserved.
//

import SwiftUI

struct DetailFilmView: View {
    @EnvironmentObject var filmsData: FilmsData
    @State var isFavorite: Bool = false
    let film: Film
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
        return dateFormatter
    }()
    
    var body: some View {
        ScrollView {
            RemoteImageURLView(imageURL: film.prefixPosterPath + film.posterPath)
                .frame(maxHeight: 400)
                .clipped()
            VStack(alignment: .leading, spacing: 16) {
                Text("\(film.title)")
                    .font(.title)
                Text("Estreno: \(dateFormatter.string(from: film.releaseDate))")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                Text("Géneros: \(film.getGenres())")
                    .font(.body)
                    .lineLimit(nil)
                Text("\(film.overview)")
                    .font(.body)
                    .lineLimit(nil)
                Spacer()
            }.padding(16)
        }
        .navigationBarItems(trailing:
            Button(action: {
                if let index = self.filmsData.films.firstIndex(where: { $0.id == self.film.id }) {
                    self.filmsData.films[index].isFavorite.toggle()
                    
                    self.isFavorite.toggle()
                }
            }, label: { Image(systemName: self.isFavorite ? "star.fill" : "star")
            })
        )
        .onAppear {
            self.isFavorite = self.film.isFavorite
        }
    }
}

struct DetailFilmView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFilmView(film: testFilmsSet[0])
    }
}
