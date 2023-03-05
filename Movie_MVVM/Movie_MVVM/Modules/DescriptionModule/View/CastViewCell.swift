// CastViewCell.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

// Ячейка с актерами
final class CastViewCell: UICollectionViewCell {
    // MARK: - Private Constants

    private enum Constants {
        static let fatalErrorText = "init(coder:) has not been implemented"
    }

    // MARK: - Private Visual Component

    private let castImageView = UIImageView()
    private let castLabel = UILabel()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        castImageView.image = nil
        castLabel.text = nil
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }

    // MARK: - Public Methods

    func updateInfo(info: Cast, _ viewModel: DescriptionViewModelProtocol?) {
        castLabel.text = info.originalName
        guard let imagePath = info.profilePath else { return }
        viewModel?.fetchImage(url: imagePath, handler: { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.castImageView.image = UIImage(data: data)
            }
        })
    }

    // MARK: - Private methods

    private func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        createCastImageView()
        createCastLabel()
    }

    private func createCastImageView() {
        castImageView.translatesAutoresizingMaskIntoConstraints = false
        castImageView.contentMode = .scaleAspectFill
        castImageView.clipsToBounds = true
        contentView.addSubview(castImageView)
        setupCastImageViewAnchor()
    }

    private func createCastLabel() {
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        castLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        castLabel.textAlignment = .center
        castLabel.numberOfLines = 2
        contentView.addSubview(castLabel)
        setupCastLabelAnchor()
    }

    private func setupCastImageViewAnchor() {
        NSLayoutConstraint.activate([
            castImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            castImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            castImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            castImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }

    private func setupCastLabelAnchor() {
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: castImageView.bottomAnchor),
            castLabel.rightAnchor.constraint(equalTo: rightAnchor),
            castLabel.leftAnchor.constraint(equalTo: leftAnchor),
            castLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
