// AssamblyBuilderProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

/// Протокол для сборщика
protocol AssamblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMovieListViewController() -> UIViewController
    func makeDescriptionViewController(movieID: Int) -> UIViewController
    func makeWebViewController(imdbId: String) -> UIViewController
}
