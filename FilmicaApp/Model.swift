//
//  Model.swift
//  FilmicaApp
//
//  Created by Cristian Espes on 22/03/2020.
//  Copyright © 2020 Cristian Espes. All rights reserved.
//

import Foundation

// MARK: - FilmsResponse
struct FilmsResponse: Codable {
    let page, totalResults, totalPages: Int
    let films: [Film]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case films = "results"
    }
}

// MARK: - Film
struct Film: Codable, Identifiable {
    let id: Int
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let adult: Bool
    let backdropPath: String?
    let originalLanguage, originalTitle: String
    let genreIDS: [Genre]
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: Date
    let prefixPosterPath = "https://image.tmdb.org/t/p/w500"
    var isFavorite = false

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    func getGenres() -> String {
        return String(genreIDS.reduce("", {"\($0), \($1.getText())"}).dropFirst(2))
    }
}

enum Genre: Int, Codable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    
    func getText() -> String {
        switch self {
        case .action:
            return "Acción"
        case .adventure:
            return "Aventura"
        case .animation:
            return "Animación"
        case .comedy:
            return "Comedia"
        case .crime:
            return "Crimen"
        case .documentary:
            return "Documental"
        case .drama:
            return "Drama"
        case .family:
            return "Familiar"
        case .fantasy:
            return "Fantasía"
        case .history:
            return "Historia"
        case .horror:
            return "Horror"
        case .music:
            return "Musical"
        case .mystery:
            return "Misterio"
        case .romance:
            return "Romance"
        case .scienceFiction:
            return "Ciencia Ficción"
        case .tvMovie:
            return "Televisión"
        case .thriller:
            return "Thriller"
        case .war:
            return "Guerra"
        case .western:
            return "Oeste"
        }
    }
}

// MARK: - Test Films Set
let testFilmsSet = [
    Film(id: 1, popularity: 2.0, voteCount: 2, video: false, posterPath: "/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg", adult: false, backdropPath: "/er1S5nJyDSkmy7i2KkPMBjbwK8x.jpg", originalLanguage: "es", originalTitle: "Título prueba", genreIDS: [.action, .tvMovie], title: "Primera película", voteAverage: 5.0, overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", releaseDate: Date()),
    Film(id: 2, popularity: 4.0, voteCount: 2, video: false, posterPath: "/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg", adult: false, backdropPath: "/er1S5nJyDSkmy7i2KkPMBjbwK8x.jpg", originalLanguage: "es", originalTitle: "Título prueba 2", genreIDS: [.action, .tvMovie], title: "Segunda película", voteAverage: 5.0, overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", releaseDate: Date())
]

final class FilmsData: ObservableObject {
    @Published var films: [Film]
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    init() {
        guard var ruta = Bundle.main.url(forResource: "films", withExtension: "json"), let rutaDisco = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            self.films = []
            return
        }
        let fichero = rutaDisco.appendingPathComponent("films").appendingPathExtension("json")
        if FileManager.default.fileExists(atPath: fichero.path) {
            ruta = fichero
        }
        do {
            let data = try Data(contentsOf: ruta)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            self.films = try jsonDecoder.decode(FilmsResponse.self, from: data).films
        } catch {
            print("Error en la carga \(error)")
            self.films = []
        }
    }
    
    init(testData: [Film]) {
        self.films = testFilmsSet
    }
}
