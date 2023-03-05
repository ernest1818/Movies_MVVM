// UIViewController+Extension.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

/// Экстеншн для  алерта ошибок
extension UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let actionTitle = "Ок"
    }

    // MARK: - Public methods

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alercAction = UIAlertAction(title: Constants.actionTitle, style: .default, handler: nil)
        alert.addAction(alercAction)
        present(alert, animated: true)
    }
}
