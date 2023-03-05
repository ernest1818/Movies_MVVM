// MovieListViewModelProtocol.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Протокол для вью модели списка фильмов
protocol MovieListViewModelProtocol {
    // MARK: - Public Properties

    var errorHandler: ErrorHandler? { get set }
    var listMovieState: ((ListViewStates) -> Void)? { get set }
    var props: ListViewStates { get set }
    var layoutHandler: VoidHandler? { get set }
    var apiKeyHandler: VoidHandler? { get set }
    var showCoreDataError: CoreDataHandler? { get set }
    var currentCategory: MovieType { get set }

    // MARK: - Public Methods

    func fetchData()
    func configureAlertHandler()
    func segmentControlAction(index: Int)
    func fetchImage(url: String, handler: @escaping DataHandler)
    func saveKeychainValue(text: String)
}
