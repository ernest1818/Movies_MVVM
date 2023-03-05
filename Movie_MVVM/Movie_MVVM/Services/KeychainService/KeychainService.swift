// KeychainService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import KeychainSwift

/// ключи для сервиса для хранения критических данных пользователя
enum KeychainKey: String {
    case apiKey
    case test
    case empty = ""
}

/// Сервис для хранения критических данных пользователя
final class KeychainService: KeychainServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let defaultString = "keychain default"
    }

    // MARK: - Private Properties

    private var keychain = KeychainSwift()

    // MARK: - Public Properties

    func save(text: String, forKey: KeychainKey) {
        keychain.set(text, forKey: forKey.rawValue)
    }

    func get(forKey: KeychainKey) -> String {
        guard let key = keychain.get(forKey.rawValue) else { return Constants.defaultString }
        return key
    }
}
