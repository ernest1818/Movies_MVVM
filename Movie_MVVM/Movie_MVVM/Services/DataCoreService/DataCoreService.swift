// DataCoreService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import CoreData
import Foundation

/// Сервис кор даты
final class DataCoreService: DataCoreServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
        static let movieDataEntityText = "MovieData"
        static let getMoviesPredicateText = "type CONTAINS %@"
        static let getMoviePredicateText = "movieId = %i"
    }

    // MARK: - Public Properties

    var errorHandler: StringHandler?

    // MARK: - Private Properties

    private let dataCore = DataCore()

    // MARK: - Public Methods

    func saveData(movies: [Movie], type: MovieType) {
        guard let entity = NSEntityDescription.entity(
            forEntityName: Constants.movieDataEntityText,
            in: dataCore.context
        )
        else { return }
        for movie in movies {
            let movieData = MovieData(entity: entity, insertInto: dataCore.context)
            movieData.title = movie.title
            movieData.movieId = Int64(movie.id)
            movieData.posterPath = movie.posterPath
            movieData.backdropPath = movie.backdropPath
            movieData.overview = movie.overview
            movieData.imdbId = movie.imdbId
            movieData.budget = Int64(movie.budget ?? 0)
            movieData.releaseDate = movie.releaseDate
            movieData.revenue = Int64(movie.revenue ?? 0)
            movieData.tagline = movie.tagline
            movieData.runtime = Int64(movie.runtime ?? 0)
            movieData.voteAverage = movie.voteAverage
            movieData.idUUID = UUID()
            movieData.type = type.rawValue
        }
        dataCore.saveContext()
    }

    func getMovies(movieType: MovieType) -> [Movie] {
        var movies: [Movie] = []
        let movieRequest = MovieData.fetchRequest()
        let predicate = NSPredicate(format: Constants.getMoviesPredicateText, movieType.rawValue)
        movieRequest.predicate = predicate
        do {
            guard let moviesData = try? dataCore.context.fetch(movieRequest) else { return [] }
            for data in moviesData {
                movies.append(Movie(
                    id: Int(data.movieId),
                    overview: data.overview ?? Constants.emptyString,
                    posterPath: data.posterPath ?? Constants.emptyString,
                    releaseDate: data.releaseDate ?? Constants.emptyString,
                    title: data.title ?? Constants.emptyString,
                    voteAverage: data.voteAverage,
                    revenue: Int(data.revenue),
                    runtime: Int(data.runtime),
                    backdropPath: data.backdropPath,
                    imdbId: data.imdbId,
                    budget: Int(data.budget),
                    genres: nil,
                    tagline: data.tagline
                ))
            }
        } catch {
            errorHandler?(error.localizedDescription)
        }
        return movies
    }

    func getMovie(id: Int) -> MoviesDetail? {
        var movie: MoviesDetail?
        let movieRequest = MovieData.fetchRequest()
        let predicate = NSPredicate(format: Constants.getMoviePredicateText, Int64(id))
        movieRequest.predicate = predicate
        let moviesData = try? dataCore.context.fetch(movieRequest).first
        movie = MoviesDetail(
            id: Int(moviesData?.movieId ?? 0),
            overview: moviesData?.overview ?? Constants.emptyString,
            posterPath: moviesData?.posterPath ?? Constants.emptyString,
            releaseDate: moviesData?.releaseDate ?? Constants.emptyString,
            title: moviesData?.title ?? Constants.emptyString,
            voteAverage: moviesData?.voteAverage ?? 0,
            revenue: Int(moviesData?.revenue ?? 0),
            runtime: Int(moviesData?.runtime ?? 0),
            backdropPath: moviesData?.backdropPath,
            imdbId: moviesData?.imdbId,
            budget: Int(moviesData?.budget ?? 0),
            genres: nil,
            tagline: moviesData?.tagline
        )
        return movie
    }
}
