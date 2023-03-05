// AssamblyBuilderTest.swift
// Copyright © Avagyan Ernest. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тест сборщика модулей
final class BuilderTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let movieId = 550
        static let imdbId = "test"
    }

    // MARK: - Private Properties

    private var builder: AssamblyBuilderProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        builder = AssamblyBuilder()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        builder = nil
    }

    func testMakeMovieListModule() {
        let movieListModule = builder?.makeMovieListViewController()
        XCTAssertTrue(movieListModule is MovieListViewController)
    }

    func testMakeDescriptionModule() {
        let descriptionModule = builder?.makeDescriptionViewController(movieID: Constants.movieId)
        XCTAssertTrue(descriptionModule is DescriptionViewController)
    }

    func testMakeWebViewModule() {
        let webViewModule = builder?.makeWebViewController(imdbId: Constants.imdbId)
        XCTAssertTrue(webViewModule is WebViewController)
    }
}
