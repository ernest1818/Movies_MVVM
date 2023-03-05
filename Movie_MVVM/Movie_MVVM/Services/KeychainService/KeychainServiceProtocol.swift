// KeychainServiceProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол  сервиса для хранения критических данных пользователя
protocol KeychainServiceProtocol {
    // MARK: - Public Methods

    func save(text: String, forKey: KeychainKey)
    func get(forKey: KeychainKey) -> String
}
