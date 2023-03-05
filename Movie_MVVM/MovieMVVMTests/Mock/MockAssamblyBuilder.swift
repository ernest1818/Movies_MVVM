// MockAssamblyBuilder.swift
// Copyright © Avagyan Ernest. All rights reserved.

@testable import Movie_MVVM
import UIKit

/// Мок сборщик экранов
final class MockAssamblyBuilder: AssamblyBuilderProtocol {
    // MARK: - Public Method

    func makeMovieListViewController() -> UIViewController {
        MovieListViewController()
    }

    func makeDescriptionViewController(movieID: Int) -> UIViewController {
        DescriptionViewController()
    }

    func makeWebViewController(imdbId: String) -> UIViewController {
        WebViewController()
    }
}
