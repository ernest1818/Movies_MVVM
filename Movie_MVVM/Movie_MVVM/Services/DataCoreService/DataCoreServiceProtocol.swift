// DataCoreServiceProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол сервиса кор даты
protocol DataCoreServiceProtocol {
    // MARK: - Public Properties

    var errorHandler: StringHandler? { get set }

    // MARK: - Public Methods

    func saveData(movies: [Movie], type: MovieType)
    func getMovies(movieType: MovieType) -> [Movie]
    func getMovie(id: Int) -> MoviesDetail?
}
