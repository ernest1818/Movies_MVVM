// WebViewModel.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Вью модель экрана WebView
final class WebViewModel: WebViewModelProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let imdbUrl = "https://www.imdb.com/title/"
    }

    // MARK: - Public Properties

    var imdbId: String?

    // MARK: - Initializers

    init(imdbId: String?) {
        self.imdbId = imdbId
    }

    // MARK: - Public Properties

    func makeBaseUrl() -> String {
        guard let id = imdbId else { return "" }
        var urlPathString = Constants.imdbUrl + id
        return urlPathString
    }
}
