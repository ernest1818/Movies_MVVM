// MovieAPIServiceTests.swift
// Copyright © Avagyan Ernest. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тест сервиса загрузки фильмов
final class MovieAPIServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let zeroCount = 0
        static let idExampleText = 297_761
        static let oneNumber = 1
        static let titleExampleText = "Fight Club"
    }

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol?
    private var movie: MoviesDetail?
    private var movieCast: [Cast]?
    private var moviesResult: [Movie]?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        movieAPIService = MockMovieAPIService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        movieAPIService = nil
    }

    func testFetchMovies() {
        movieAPIService?.fetchMovies(method: .upcoming, completion: { result in
            switch result {
            case let .success(movies):
                self.moviesResult = movies.results
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
        XCTAssertEqual(moviesResult?[Constants.zeroCount].id, Constants.idExampleText)
    }

    func testFetchMovieDetail() {
        movieAPIService?.fetchMovie(movieId: Constants.oneNumber, completion: { [weak self] result in
            switch result {
            case let .success(movie):
                self?.movie = movie
            case let .failure(error):
                print(error.localizedDescription)
            }
        })

        XCTAssertEqual(movie?.title, Constants.titleExampleText)
    }

    func testFetchCasts() {
        movieAPIService?.fetchMovieCast(movieId: Constants.zeroCount, completion: { [weak self] result in
            switch result {
            case let .success(casts):
                self?.movieCast = casts.cast
            case let .failure(error):
                print(error.localizedDescription)
            }
        })

        XCTAssertNotEqual(movieCast?.count, Constants.zeroCount)
    }

    func testPerformanceExample() throws {
        measure {}
    }
}
