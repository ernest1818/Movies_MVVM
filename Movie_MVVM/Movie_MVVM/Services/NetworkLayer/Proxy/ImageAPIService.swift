// ImageAPIService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

///  Сервис загрузки картинок из сети
final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let baseImageURLText = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Public Methods

    func loadImage(byUrl: String, _ completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: Constants.baseImageURLText + byUrl) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
