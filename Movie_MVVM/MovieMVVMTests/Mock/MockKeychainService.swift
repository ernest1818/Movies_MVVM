// MockKeychainService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation
@testable import Movie_MVVM

/// Мок сервис для хранения критических данных пользователя
final class MockKeychainService: KeychainServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let testApiString = "testApi"
    }

    // MARK: - Public Properties

    var anyKey: String?

    // MARK: - Public Methods

    func save(text: String, forKey: KeychainKey) {
        anyKey = text
    }

    func get(forKey: KeychainKey) -> String {
        Constants.testApiString
    }
}
