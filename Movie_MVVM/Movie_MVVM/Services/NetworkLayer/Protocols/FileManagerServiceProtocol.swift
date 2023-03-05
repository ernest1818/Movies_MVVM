// FileManagerServiceProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол сервиса файл менеджера
protocol FileManagerServiceProtocol {
    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data?)
    func getImageFromCache(url: String) -> Data?
}
