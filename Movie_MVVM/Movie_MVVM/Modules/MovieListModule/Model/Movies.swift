// Movies.swift
// Copyright © Avagyan Ernest. All rights reserved.

import CoreData
import Foundation

/// Детали фильма
struct Movie: Decodable {
    /// Идентификатор
    let id: Int
    /// Описание
    let overview: String
    /// Путь к фото постера
    let posterPath: String
    /// Дата релиза
    let releaseDate: String
    /// Название
    let title: String
    /// Рейтиг
    let voteAverage: Float
    /// Сборы
    let revenue: Int?
    /// Продолжительность
    let runtime: Int?
    /// Путь к фото заднего плана
    let backdropPath: String?
    /// Идентификатор imdb
    let imdbId: String?
    /// Бюджет
    let budget: Int?
    /// Жанры фильмов
    let genres: [Genres]?
    /// Слоган
    let tagline: String?
}
