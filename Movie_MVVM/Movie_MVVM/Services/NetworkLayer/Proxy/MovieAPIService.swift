// MovieAPIService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Методы для запросов в сеть
enum MovieType: String {
    case popular
    case upcoming
    case topRated = "top_rated"
}

///  Сервис загрузки данных
final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let baseUrl = "https://api.themoviedb.org/3/movie/"
        static let method = "/popular"
        static let apiKey = "api_key"
        static let credits = "/credits"
        static let languageKey = "language"
        static let languageValue = "ru-RU"
    }

    private var keychainService: KeychainServiceProtocol?

    // MARK: - Initializers

    init(keychainService: KeychainServiceProtocol? = nil) {
        self.keychainService = keychainService
    }

    // MARK: - Public Properties

    func fetchMovies(method: MovieType, completion: @escaping (Result<MoviesResult, Error>) -> ()) {
        guard let apiKey = keychainService?.get(forKey: .apiKey) else { return }
        let queryItems = [
            URLQueryItem(name: Constants.apiKey, value: apiKey),
            URLQueryItem(name: Constants.languageKey, value: Constants.languageValue)
        ]
        guard
            var urlComps = URLComponents(string: "\(Constants.baseUrl)\(method.rawValue)")
        else { return }
        urlComps.queryItems = queryItems
        guard let result = urlComps.url else { return }
        getData(url: result, completion: completion)
    }

    func fetchMovie(movieId: Int, completion: @escaping (Result<MoviesDetail, Error>) -> ()) {
        guard let apiKey = keychainService?.get(forKey: .apiKey) else { return }
        let queryItems = [
            URLQueryItem(name: Constants.apiKey, value: apiKey),
            URLQueryItem(name: Constants.languageKey, value: Constants.languageValue)
        ]
        guard var urlComps = URLComponents(string: "\(Constants.baseUrl)\(movieId)") else { return }
        urlComps.queryItems = queryItems
        guard let result = urlComps.url else { return }
        getData(url: result, completion: completion)
    }

    func fetchMovieCast(movieId: Int, completion: @escaping (Result<MovieCast, Error>) -> ()) {
        guard let apiKey = keychainService?.get(forKey: .apiKey) else { return }
        let queryItems = [
            URLQueryItem(name: Constants.apiKey, value: apiKey),
            URLQueryItem(name: Constants.languageKey, value: Constants.languageValue)
        ]
        guard
            var urlComps = URLComponents(string: "\(Constants.baseUrl)\(movieId)\(Constants.credits)")
        else {
            return
        }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
        print(url)
        getData(url: url, completion: completion)
    }

    // MARK: - Private Methods

    private func getData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> ()) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
