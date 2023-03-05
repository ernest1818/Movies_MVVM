// MockDataCoreService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation
@testable import Movie_MVVM

/// Мок сервис кор даты
final class MockDataCoreService: DataCoreServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
        static let zeroInt = 0
        static let zeroFloat: Float = 0.0
        static let barMovieId = 1
        static let barMovieOwerView = "baz"
        static let barMoviePosterPath = "foo"
        static let barMovieReleaseData = "Boo"
        static let barMovieTitle = "gaz"
        static let barMovieVoteAverage: Float = 2.5
        static let barMovieRevenue = 2
        static let barMovieRunTime = 3
        static let barMovieBackdropPath = "bar"
        static let barMovieImdbId = "baz"
        static let barMovieBudget = 4
        static let barMovieGenres: [Genres]? = nil
        static let barMovieTagline = "baz"
        static let bazMovieId = 5
        static let bazMovieOwerView = "bar"
        static let bazMoviePosterPath = "boo"
        static let bazMovieReleaseData = "foo"
        static let bazMovieTitle = "zaz"
        static let bazMovieVoteAverage: Float = 1.5
        static let bazMovieRevenue = 6
        static let bazMovieRunTime = 7
        static let bazMovieBackdropPath = "baz"
        static let bazMovieImdbId = "bar"
        static let bazMovieBudget = 8
        static let bazMovieGenres: [Genres]? = nil
        static let bazMovieTagline = "bar"
    }

    // MARK: - Public Properties

    var errorHandler: Movie_MVVM.StringHandler?

    // MARK: - Private Properties

    private var dataCore = DataCore()
    private var movies: [Movie] = []

    // MARK: - Public Methods

    func saveData(movies: [Movie_MVVM.Movie], type: Movie_MVVM.MovieType) {
        self.movies = movies
    }

    func getMovies(movieType: Movie_MVVM.MovieType) -> [Movie_MVVM.Movie] {
        let barMovie = Movie(
            id: Constants.barMovieId,
            overview: Constants.barMovieOwerView,
            posterPath: Constants.barMoviePosterPath,
            releaseDate: Constants.barMovieReleaseData,
            title: Constants.barMovieTitle,
            voteAverage: Constants.barMovieVoteAverage,
            revenue: Constants.barMovieRevenue,
            runtime: Constants.barMovieRunTime,
            backdropPath: Constants.barMovieBackdropPath,
            imdbId: Constants.barMovieImdbId,
            budget: Constants.barMovieBudget,
            genres: Constants.barMovieGenres,
            tagline: Constants.barMovieTagline
        )
        let bazMovie = Movie(
            id: Constants.bazMovieId,
            overview: Constants.bazMovieOwerView,
            posterPath: Constants.bazMoviePosterPath,
            releaseDate: Constants.bazMovieReleaseData,
            title: Constants.bazMovieTitle,
            voteAverage: Constants.bazMovieVoteAverage,
            revenue: Constants.bazMovieRevenue,
            runtime: Constants.bazMovieRunTime,
            backdropPath: Constants.bazMovieBackdropPath,
            imdbId: Constants.bazMovieImdbId,
            budget: Constants.bazMovieBudget,
            genres: Constants.bazMovieGenres,
            tagline: Constants.bazMovieTagline
        )
        movies.append(bazMovie)
        movies.append(barMovie)
        return movies
    }

    func getMovie(id: Int) -> Movie_MVVM.MoviesDetail? {
        var movie: MoviesDetail?
        let moviesData = getMovies(movieType: .popular).first
        movie = MoviesDetail(
            id: Int(moviesData?.id ?? Constants.zeroInt),
            overview: moviesData?.overview ?? Constants.emptyString,
            posterPath: moviesData?.posterPath ?? Constants.emptyString,
            releaseDate: moviesData?.releaseDate ?? Constants.emptyString,
            title: moviesData?.title ?? Constants.emptyString,
            voteAverage: moviesData?.voteAverage ?? Constants.zeroFloat,
            revenue: Int(moviesData?.revenue ?? Constants.zeroInt),
            runtime: Int(moviesData?.runtime ?? Constants.zeroInt),
            backdropPath: moviesData?.backdropPath,
            imdbId: moviesData?.imdbId,
            budget: Int(moviesData?.budget ?? Constants.zeroInt),
            genres: nil,
            tagline: moviesData?.tagline
        )
        return movie
    }
}
