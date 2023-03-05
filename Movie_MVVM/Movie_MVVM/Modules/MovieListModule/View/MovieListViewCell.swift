// MovieListViewCell.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

/// Ячейка с фильмом
final class MovieListViewCell: UITableViewCell {
    // MARK: - Private Constants

    private enum Constants {
        static let layerCornerRadius: CGFloat = 15
    }

    // MARK: - Visual Components

    private let movieImageView = UIImageView()
    private let movieNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let voteAverageLabel = UILabel()

    // MARK: - Life Cycles

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieNameLabel.text = nil
        descriptionLabel.text = nil
        voteAverageLabel.text = nil
    }

    // MARK: - Public Methods

    func configure(_ movie: Movie, viewModel: MovieListViewModelProtocol) {
        movieDestribution(movie)
        setupImages(path: movie.posterPath, viewModel: viewModel)
    }

    // MARK: - Private Methods

    private func setupUI() {
        createImageView()
        createNameLabel()
        createDescriptionLabel()
        createAverageLabel()
    }

    private func createImageView() {
        movieImageView.layer.cornerRadius = Constants.layerCornerRadius
        movieImageView.layer.masksToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)
        createImageViewAnchor()
    }

    private func createNameLabel() {
        movieNameLabel.textAlignment = .center
        movieNameLabel.lineBreakMode = .byWordWrapping
        movieNameLabel.numberOfLines = 0
        movieNameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieNameLabel)
        createNameLabelAnchor()
    }

    private func createDescriptionLabel() {
        descriptionLabel.numberOfLines = 10
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        createDiscriptionLabelAnchor()
    }

    private func createAverageLabel() {
        voteAverageLabel.backgroundColor = .systemOrange
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLabel.layer.cornerRadius = 5
        voteAverageLabel.layer.masksToBounds = true
        voteAverageLabel.textAlignment = .center
        voteAverageLabel.font = .systemFont(ofSize: 15, weight: .bold)
        movieImageView.addSubview(voteAverageLabel)
        createAverageLabelAnchor()
    }

    private func createAverageLabelAnchor() {
        voteAverageLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -5).isActive = true
        voteAverageLabel.rightAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: -5).isActive = true
        voteAverageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        voteAverageLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createImageViewAnchor() {
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        movieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }

    private func createNameLabelAnchor() {
        movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        movieNameLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 40).isActive = true
        movieNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40).isActive = true
    }

    private func createDiscriptionLabelAnchor() {
        descriptionLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 16).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }

    private func movieDestribution(_ movie: Movie) {
        movieNameLabel.text = movie.title
        descriptionLabel.text = movie.overview
        voteAverageLabel.text = "\(movie.voteAverage)"
    }

    private func setupImages(path: String, viewModel: MovieListViewModelProtocol) {
        viewModel.fetchImage(url: path, handler: { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: data)
            }
        })
    }
}
