// MovieListCoordinatorProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол координатора экрана списка фильмов
protocol MovieListCoordinatorProtocol {
    func showMovieListModule()
    func showDescriptionModule(movieID: Int)
    func showWebViewModule(imdbId: String)
}
