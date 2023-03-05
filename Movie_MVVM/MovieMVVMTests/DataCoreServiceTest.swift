// DataCoreServiceTest.swift
// Copyright © Avagyan Ernest. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тест дата кор сервиса
final class DataCoreServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let oneNumber = 0
    }

    // MARK: - Private Properties

    private var dataCoreService: DataCoreServiceProtocol?
    private var movies: [Movie] = []
    private var moviesResult: [Movie] = []
    private var movie: MoviesDetail?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        dataCoreService = MockDataCoreService()
        let bazMovie = Movie(
            id: 5,
            overview: "bar",
            posterPath: "boo",
            releaseDate: "foo",
            title: "zaz",
            voteAverage: 1.5,
            revenue: 6,
            runtime: 7,
            backdropPath: "baz",
            imdbId: "bar",
            budget: 8,
            genres: nil,
            tagline: "bar"
        )
        movies.append(bazMovie)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        dataCoreService = nil
    }

    func testDataCoreSave() {
        dataCoreService?.saveData(movies: movies, type: .topRated)
    }

    func testDataCoreServiceSaveAndGetMovies() {
        guard let result = dataCoreService?.getMovies(movieType: .topRated) else { return }
        moviesResult = result

        XCTAssertEqual(moviesResult.count, 2)
        XCTAssertNil(moviesResult[Constants.oneNumber].genres)
    }

    func testDataCoreServiceGetMovie() {
        guard let result = dataCoreService?.getMovie(id: Constants.oneNumber) else { return }
        movie = result
        XCTAssertEqual(movie?.overview, "bar")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
