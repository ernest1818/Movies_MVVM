// DescriptionViewModelTest.swift
// Copyright © Avagyan Ernest. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тест вью-модели экрана описания фильмов
final class DescriptionViewModelTest: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let castsCount = 6
        static let testDataText = "test"
        static let mockIdText = 5
        static let movieIDText = 1
    }

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol!
    private var imageService: ImageServiceProtocol!
    private var descriptionViewModel: DescriptionViewModelProtocol?
    private var dataCoreService: DataCoreServiceProtocol!
    private var keychainService: KeychainServiceProtocol!

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        movieAPIService = MockMovieAPIService()
        imageService = MockImageService()
        dataCoreService = MockDataCoreService()
        keychainService = MockKeychainService()
        descriptionViewModel = DescriptionViewModel(
            movieAPIService: movieAPIService,
            imageService: imageService,
            movieID: Constants.movieIDText,
            dataCoreService: dataCoreService
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        descriptionViewModel = nil
    }

    func testFetchCasts() throws {
        descriptionViewModel?.fetchCasts()
        XCTAssertEqual(descriptionViewModel?.casts?.count, Constants.castsCount)
    }

    func testFetchImage() {
        descriptionViewModel?.fetchImage(url: Constants.testDataText, handler: { data in
            XCTAssertEqual(data, Constants.testDataText.data(using: .utf8))
        })
    }

    func testFetchMovie() {
        descriptionViewModel?.fetchData()
        XCTAssertEqual(descriptionViewModel?.movieDetail?.id, Constants.mockIdText)
    }

    func testPerformanceExample() throws {
        measure {}
    }
}
