// ListViewStates.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Пропс
enum ListViewStates {
    /// инициализация
    case initial
    /// результат
    case success([Movie])
    /// сбой
    case failure(Error)
}
