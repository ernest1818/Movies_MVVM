// Cast.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Информация об актере
struct Cast: Decodable {
    /// Путь к картинке
    var profilePath: String?
    /// Имя актера
    var originalName: String?
}
