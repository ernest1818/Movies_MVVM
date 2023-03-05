// MockMoviewAPIService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation
@testable import Movie_MVVM

/// Мок сервис загрузки фильмов
final class MockMovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockMovieJsonName = "MockMovie"
        static let mockMovieInfoJsonName = "MockMovieInfo"
        static let mockCastJsonName = "MockCast"
        static let jsonText = "json"
        static let errorText = "error"
    }

    // MARK: - Public Method

    func fetchMovies(method: MovieType, completion: @escaping (Result<MoviesResult, Error>) -> ()) {
        guard
            let url = Bundle.main.url(forResource: Constants.mockMovieJsonName, withExtension: Constants.jsonText)
        else {
            return
        }
        getData(url: url, completion: completion)
    }

    func fetchMovie(movieId: Int, completion: @escaping (Result<MoviesDetail, Error>) -> ()) {
        guard
            let url = Bundle.main.url(forResource: Constants.mockMovieInfoJsonName, withExtension: Constants.jsonText)
        else {
            return
        }
        getData(url: url, completion: completion)
    }

    func fetchMovieCast(movieId: Int, completion: @escaping (Result<MovieCast, Error>) -> ()) {
        guard
            let url = Bundle.main.url(forResource: Constants.mockCastJsonName, withExtension: Constants.jsonText)
        else {
            return
        }
        getData(url: url, completion: completion)
    }

    private func getData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> ()) {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let object = try decoder.decode(T.self, from: data)
            completion(.success(object))
        } catch {
            completion(.failure(error))
        }
    }
}
