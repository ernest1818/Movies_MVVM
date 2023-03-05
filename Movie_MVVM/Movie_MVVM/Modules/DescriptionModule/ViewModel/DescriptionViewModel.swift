// DescriptionViewModel.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Вью модель экрана описания фильма
final class DescriptionViewModel: DescriptionViewModelProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let zeroInt = 0
    }

    // MARK: - Public Properties

    var updateViewHandler: VoidHandler?
    var updateViewData: VoidHandler?
    var errorHandler: ErrorHandler?
    var movieDetail: MoviesDetail?
    var movieID: Int?
    var casts: [Cast]?

    // MARK: - Private Properties

    private var imageService: ImageServiceProtocol
    private var dataCoreService: DataCoreServiceProtocol?
    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: - Initializers

    init(
        movieAPIService: MovieAPIServiceProtocol,
        imageService: ImageServiceProtocol,
        movieID: Int,
        dataCoreService: DataCoreServiceProtocol
    ) {
        self.movieAPIService = movieAPIService
        self.imageService = imageService
        self.movieID = movieID
        self.dataCoreService = dataCoreService
    }

    // MARK: - Public Methods

    func fetchData() {
        loadMovie(id: movieID ?? 0)
    }

    func fetchCasts() {
        fetchCasts(id: movieID ?? 0)
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

    // MARK: - Private Methods

    private func loadMovie(id: Int) {
        let movie = dataCoreService?.getMovie(id: id)
        if movie != nil {
            movieDetail = movie
            updateViewData?()
        } else {
            fetchMovieID(id: id)
        }
    }

    private func fetchMovieID(id: Int) {
        movieAPIService.fetchMovie(movieId: movieID ?? Constants.zeroInt) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movie):
                self.movieDetail = movie
                self.updateViewHandler?()
            case let .failure(error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }

    private func fetchCasts(id: Int) {
        movieAPIService.fetchMovieCast(movieId: movieID ?? Constants.zeroInt) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(cast):
                guard let casts = cast.cast else { return }
                self.casts = casts
                self.updateViewHandler?()
            case let .failure(error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }
}
