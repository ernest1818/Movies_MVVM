// MovieListViewModel.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Вью модель списка фильмов
final class MovieListViewModel: MovieListViewModelProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
    }

    // MARK: - Public Properties

    var errorHandler: ErrorHandler?
    var listMovieState: ((ListViewStates) -> Void)?
    var layoutHandler: VoidHandler?
    var apiKeyHandler: VoidHandler?
    var showCoreDataError: CoreDataHandler?
    var currentCategory: MovieType = .popular
    var props: ListViewStates = .initial {
        didSet {
            layoutHandler?()
        }
    }

    // MARK: - Private Properties

    private var keychainService: KeychainServiceProtocol
    private var movieAPIService: MovieAPIServiceProtocol
    private var imageService: ImageServiceProtocol
    private var dataCoreService: DataCoreServiceProtocol?

    // MARK: - Initializers

    init(
        movieAPIService: MovieAPIServiceProtocol,
        imageService: ImageServiceProtocol,
        keychainService: KeychainServiceProtocol,
        dataCoreService: DataCoreServiceProtocol
    ) {
        self.movieAPIService = movieAPIService
        self.imageService = imageService
        self.keychainService = keychainService
        self.dataCoreService = dataCoreService
    }

    // MARK: - Public Methods

    func fetchData() {
        loadMovies(movieType: currentCategory)
    }

    func segmentControlAction(index: Int) {
        switch index {
        case 0:
            currentCategory = .popular
        case 1:
            currentCategory = .topRated
        case 2:
            currentCategory = .upcoming
        default:
            break
        }
        loadMovies(movieType: currentCategory)
    }

    func fetchImage(url: String, handler: @escaping DataHandler) {
        imageService.getImage(byUrl: url) { [weak self] result in
            switch result {
            case let .success(data):
                guard let data = data else { return }
                handler(data)
            case let .failure(error):
                self?.errorHandler?(error.localizedDescription)
            }
        }
    }

    func saveKeychainValue(text: String) {
        keychainService.save(text: text, forKey: .apiKey)
    }

    func configureAlertHandler() {
        if keychainService.get(forKey: .apiKey).isEmpty {
            apiKeyHandler?()
        }
    }

    // MARK: - Private Methods

    private func loadMovies(movieType: MovieType) {
        guard let movies = dataCoreService?.getMovies(movieType: movieType) else { return }
        if !movies.isEmpty {
            props = .success(movies)
        } else {
            fetchMovies(movieType: movieType)
        }
    }

    private func fetchMovies(movieType: MovieType) {
        movieAPIService.fetchMovies(method: movieType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.dataCoreService?.saveData(movies: result.results, type: movieType)
                guard
                    let movies = self.dataCoreService?.getMovies(movieType: movieType)
                else {
                    return
                }
                self.props = .success(movies)
            case let .failure(error):
                self.props = .failure(error)
            }
        }
    }

    private func coreDataErrorAlert() {
        dataCoreService?.errorHandler = { [weak self] error in
            self?.showCoreDataError?(error)
        }
    }
}
