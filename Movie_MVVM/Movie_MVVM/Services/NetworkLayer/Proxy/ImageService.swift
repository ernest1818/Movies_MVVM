// ImageService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Сервис картинок
final class ImageService: ImageServiceProtocol {
    // MARK: - Private Properties

    var proxy: ProxyProtocol

    // MARK: - Initializers

    init(proxy: ProxyProtocol) {
        self.proxy = proxy
    }

    // MARK: - Public Methods

    func getImage(byUrl: String, _ completion: @escaping (Result<Data?, Error>) -> ()) {
        proxy.loadImage(byUrl: byUrl) { result in
            switch result {
            case let .success(imageData):
                completion(.success(imageData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
