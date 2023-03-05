// MovieAPIServiceProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол загрузки данных из сети
protocol MovieAPIServiceProtocol {
    // MARK: - Public Methods

    func fetchMovies(method: MovieType, completion: @escaping (Result<MoviesResult, Error>) -> ())
    func fetchMovie(movieId: Int, completion: @escaping (Result<MoviesDetail, Error>) -> ())
    func fetchMovieCast(movieId: Int, completion: @escaping (Result<MovieCast, Error>) -> ())
}
