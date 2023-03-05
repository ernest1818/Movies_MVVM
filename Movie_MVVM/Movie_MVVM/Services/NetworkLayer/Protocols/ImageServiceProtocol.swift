// ImageServiceProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол сервиса картинок
protocol ImageServiceProtocol {
    // MARK: - Public Methods

    func getImage(byUrl: String, _ completion: @escaping (Result<Data?, Error>) -> ())
}
