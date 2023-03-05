// VebViewModelProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол для вью модели
protocol WebViewModelProtocol {
    var imdbId: String? { get set }
    func makeBaseUrl() -> String
}
