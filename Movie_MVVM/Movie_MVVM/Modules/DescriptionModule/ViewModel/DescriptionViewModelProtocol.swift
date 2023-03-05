// DescriptionViewModelProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол вью модели экрана описания фильма
protocol DescriptionViewModelProtocol {
    // MARK: - Public Properties

    var movieID: Int? { get set }
    var movieDetail: MoviesDetail? { get set }
    var casts: [Cast]? { get set }
    var updateViewHandler: VoidHandler? { get set }
    var errorHandler: ErrorHandler? { get set }

    // MARK: - Public Methods

    func fetchData()
    func fetchCasts()
    func fetchImage(url: String, handler: @escaping DataHandler)
}
