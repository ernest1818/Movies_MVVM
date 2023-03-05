// AppCoordinator.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Координатор приложения
final class AppCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var assemblyBuilder: AssamblyBuilderProtocol?

    // MARK: - Initializers

    convenience init(assemblyBuilder: AssamblyBuilderProtocol?) {
        self.init()
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public Methods

    override func start() {
        toMovieList()
    }

    private func toMovieList() {
        let coordinator = MovieListCoordinator(assemblyBuilder: assemblyBuilder)
        addDependency(coordinator)
        coordinator.start()
    }
}
