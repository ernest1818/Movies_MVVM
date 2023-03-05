// ImageAPIServiceProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол  сервиса загрузки картинки
protocol ImageAPIServiceProtocol {
    // MARK: - Public Methods

    func loadImage(byUrl: String, _ completion: @escaping (Result<Data, Error>) -> ())
}
