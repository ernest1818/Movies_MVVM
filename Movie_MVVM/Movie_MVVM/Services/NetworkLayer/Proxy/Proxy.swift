// Proxy.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Прокси
final class Proxy: ProxyProtocol {
    // MARK: - public Properties

    let imageAPIService: ImageAPIServiceProtocol
    let fileManagerService: FileManagerServiceProtocol

    // MARK: - Initializers

    init(imageAPIService: ImageAPIServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageAPIService = imageAPIService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Public Method

    func loadImage(byUrl: String, _ completion: @escaping (Result<Data, Error>) -> ()) {
        guard let imageData = fileManagerService.getImageFromCache(url: byUrl) else {
            imageAPIService.loadImage(byUrl: byUrl) { result in
                switch result {
                case let .success(data):
                    self.fileManagerService.saveImageToCache(url: byUrl, data: data)
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            return
        }
        completion(.success(imageData))
    }
}
