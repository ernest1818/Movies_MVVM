// ProxyProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Прокси протокол
protocol ProxyProtocol {
    // MARK: - Public Methods

    func loadImage(byUrl: String, _ completion: @escaping (Result<Data, Error>) -> ())
}
