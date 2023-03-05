// MovieListCoordinator.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

/// Координатор экрана списка фильмов
final class MovieListCoordinator: BaseCoordinator, MovieListCoordinatorProtocol {
    // MARK: - Public Properties

    var rootNavController: UINavigationController?
    var assemblyBuilder: AssamblyBuilderProtocol?

    // MARK: - Initializers

    convenience init(assemblyBuilder: AssamblyBuilderProtocol?) {
        self.init()
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public Methods

    override func start() {
        showMovieListModule()
    }

    func showMovieListModule() {
        guard let controller = assemblyBuilder?.makeMovieListViewController() as? MovieListViewController
        else { return }
        controller.toDescriptionModule = { [weak self] id in
            self?.showDescriptionModule(movieID: id)
        }

        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        rootNavController = rootController
    }

    func showDescriptionModule(movieID: Int) {
        guard
            let controller = assemblyBuilder?
            .makeDescriptionViewController(movieID: movieID) as? DescriptionViewController
        else {
            return
        }
        controller.moveWebView = { [weak self] idString in
            self?.showWebViewModule(imdbId: idString)
        }
        rootNavController?.pushViewController(controller, animated: true)
    }

    func showWebViewModule(imdbId: String) {
        guard
            let controller = assemblyBuilder?.makeWebViewController(imdbId: imdbId) as? WebViewController
        else {
            return
        }
        rootNavController?.present(controller, animated: true)
    }
}
