// AssamblyBuilder.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

/// Cборщик экранов
final class AssamblyBuilder: AssamblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMovieListViewController() -> UIViewController {
        let view = MovieListViewController()
        let keychainService = KeychainService()
        let imageAPIService = ImageAPIService()
        let fileManagerService = FileManagerService()
        let proxy = Proxy(imageAPIService: imageAPIService, fileManagerService: fileManagerService)
        let dataCoreService = DataCoreService()
        let movieAPIService = MovieAPIService(keychainService: keychainService)
        let imageService = ImageService(proxy: proxy)
        let viewModel = MovieListViewModel(
            movieAPIService: movieAPIService,
            imageService: imageService,
            keychainService: keychainService,
            dataCoreService: dataCoreService
        )
        view.movieListViewModel = viewModel
        return view
    }

    func makeDescriptionViewController(movieID: Int) -> UIViewController {
        let view = DescriptionViewController()
        let keychainService = KeychainService()
        let dataCoreService = DataCoreService()
        let imageAPIService = ImageAPIService()
        let fileManagerService = FileManagerService()
        let proxy = Proxy(imageAPIService: imageAPIService, fileManagerService: fileManagerService)
        let movieAPIService = MovieAPIService(keychainService: keychainService)
        let imageService = ImageService(proxy: proxy)
        let viewModel = DescriptionViewModel(
            movieAPIService: movieAPIService,
            imageService: imageService,
            movieID: movieID,
            dataCoreService: dataCoreService
        )
        view.descriptionViewModel = viewModel
        return view
    }

    func makeWebViewController(imdbId: String) -> UIViewController {
        let view = WebViewController()
        let viewModel = WebViewModel(imdbId: imdbId)
        view.webViewModel = viewModel
        return view
    }
}
