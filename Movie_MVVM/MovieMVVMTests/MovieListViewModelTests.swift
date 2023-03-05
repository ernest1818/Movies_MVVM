// MovieListViewModelTests.swift
// Copyright © Avagyan Ernest. All rights reserved.

@testable import Movie_MVVM

import XCTest

/// Тест вью-модели экрана списка фильмов
final class MovieListViewModelTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let testDataText = "test2"
        static let testApiString = "testApi"
        static let zeroNumber = 0
        static let oneNumber = 1
        static let twoNumber = 2
        static let moviesCount = 2
    }

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol!
    private var imageService: ImageServiceProtocol!
    private var movieListViewModel: MovieListViewModelProtocol?
    private var dataCoreService: DataCoreServiceProtocol!
    private var keychainService = MockKeychainService()

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        movieAPIService = MockMovieAPIService()
        imageService = MockImageService()
        dataCoreService = MockDataCoreService()
        movieListViewModel = MovieListViewModel(
            movieAPIService: movieAPIService,
            imageService: imageService,
            keychainService: keychainService,
            dataCoreService: dataCoreService
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        movieAPIService = nil
        imageService = nil
        dataCoreService = nil
        movieListViewModel = nil
    }

    func testSegmentControlAction() throws {
        movieListViewModel?.segmentControlAction(index: Constants.zeroNumber)
        XCTAssertEqual(movieListViewModel?.currentCategory, .popular)
        movieListViewModel?.segmentControlAction(index: Constants.oneNumber)
        XCTAssertEqual(movieListViewModel?.currentCategory, .topRated)
        movieListViewModel?.segmentControlAction(index: Constants.twoNumber)
        XCTAssertEqual(movieListViewModel?.currentCategory, .upcoming)
    }

    func testFetchData() {
        movieListViewModel?.fetchData()
        switch movieListViewModel?.props {
        case let .success(movies):
            XCTAssertEqual(movies.count, Constants.moviesCount)
        case let .failure(error):
            XCTFail(error.localizedDescription)
        default:
            break
        }
    }

    func testFetchImage() {
        movieListViewModel?.fetchImage(url: Constants.testDataText, handler: { data in
            XCTAssertEqual(data, Constants.testDataText.data(using: .utf8))
        })
    }

    func testApiKey() {
        movieListViewModel?.saveKeychainValue(text: Constants.testApiString)
        XCTAssertNotNil(keychainService.anyKey)
        var apiKey = keychainService.get(forKey: .test)
        XCTAssertEqual(apiKey, Constants.testApiString)
    }

    func testPerformanceExample() throws {
        measure {}
    }
}
