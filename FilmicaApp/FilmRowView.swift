//
//  FilmRowView.swift
//  FilmicaApp
//
//  Created by Cristian Espes on 22/03/2020.
//  Copyright © 2020 Cristian Espes. All rights reserved.
//

import SwiftUI

struct FilmRowView: View {
    let film: Film
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    var body: some View {
        HStack {
            RemoteImageURLView(imageURL: film.prefixPosterPath + film.posterPath)
                .frame(width: 100, height: 140)
                .cornerRadius(20)
                .shadow(radius: 5)
            VStack(alignment: .leading, spacing: 16) {
                Text("\(film.title)")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                        .lineLimit(2)
                Text("\(dateFormatter.string(from: film.releaseDate))")
                    .font(.body)
            }
            Spacer()
        }
    }
}

struct FilmRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmRowView(film: testFilmsSet[0])
    }
}
