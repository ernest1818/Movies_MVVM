// MoviesResult.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Модель для принятия информации из сервера
struct MoviesResult: Decodable {
    /// ответ сервера
    let results: [Movie]
}
