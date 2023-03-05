// MockImageService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation
@testable import Movie_MVVM

/// Мок сервис загрузки картинок
final class MockImageService: ImageServiceProtocol {
    // MARK: - Public Method

    func getImage(byUrl: String, _ completion: @escaping (Result<Data?, Error>) -> ()) {
        let data = byUrl.data(using: .utf8)
        completion(.success(data))
    }
}
