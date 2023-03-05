// DescriptionViewCell.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

protocol PresentViewControllerDelegate: AnyObject {
    func goToVC(param: UIViewController)
}

/// Ячейка отображения описаний фильма
final class DescriptionViewCell: UITableViewCell {
    // MARK: - Private Constants

    private enum Constants {
        static let aboutMovieText = "О фильме:"
        static let castText = "В ролях:"
        static let collectionCellIdentifier = "cell"
        static let runtimeText = "Продолжительность: "
        static let minutes = "мин."
        static let budgetText = "Бюджет: "
        static let playImageName = "play.circle"
        static let revenueText = "Сборы: "
        static let genreText = "Жанр: "
        static let collectionViewLineSpacing: CGFloat = 1
        static let emptyString = ""
        static let zeroInt = 0
    }

    // MARK: - Private Visual Components

    private let posterImageView = UIImageView()
    private let backdropImageView = UIImageView()
    private let movieNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let avarageLabel = UILabel()
    private let aboutMovieLabel = UILabel()
    private let castLabel = UILabel()
    private let conteinerView = UIView()
    private var collectionView: UICollectionView?
    private let runtimeLabel = UILabel()
    private let budgetLabel = UILabel()
    private let revenueLabel = UILabel()
    private let genreLabel = UILabel()
    private let playImageView = UIImageView()

    // MARK: - Public Properties

    var imdbId = Constants.emptyString
    weak var delegate: PresentViewControllerDelegate?
    var moveWebView: StringHandler?

    // MARK: - Private properties

    private var cast: MovieCast = .init()
    private var descriptionViewModel: DescriptionViewModelProtocol?

    // MARK: - LifeCycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }

    // MARK: - Public Methods

    func configure(_ movie: MoviesDetail?, _ viewModel: DescriptionViewModelProtocol) {
        guard let movie = movie else { return }
        getPosterImage(movie, viewModel)
        getBackdropImage(movie, viewModel)
        movieDestribution(movie)
        descriptionViewModel = viewModel
    }

    // MARK: - Private Methods

    private func setupUI() {
        createBackdropImageView()
        createPlayImageView()
        createAvarageLabel()
        createPosterImageView()
        createAboutMovieeLabel()
        createMovieNameLabel()
        createRuntimeLabel()
        createBudgetLabel()
        createRevenueLabel()
        createGenreLabel()
        createDescriptionLabel()
        createCastLabel()
        createContainerView()
        createCollectionView()
    }

    private func createMovieNameLabel() {
        movieNameLabel.textAlignment = .left
        movieNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.numberOfLines = 0
        contentView.addSubview(movieNameLabel)
        createNameLabelAnchor()
    }

    private func createRuntimeLabel() {
        runtimeLabel.textColor = .lightGray
        runtimeLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        runtimeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(runtimeLabel)
        setupRuntimeLabelAnchor()
    }

    private func createBudgetLabel() {
        budgetLabel.textColor = .lightGray
        budgetLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(budgetLabel)
        setupBudgetLabelAnchor()
    }

    private func createRevenueLabel() {
        revenueLabel.textColor = .lightGray
        revenueLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        revenueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(revenueLabel)
        setupRevenueLabelAnchor()
    }

    private func createGenreLabel() {
        genreLabel.textColor = .lightGray
        genreLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(genreLabel)
        setupGenreLabelAnchor()
    }

    private func createBackdropImageView() {
        backdropImageView.backgroundColor = .red
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
        backdropImageView
            .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goWebControllerAction)))
        backdropImageView.isUserInteractionEnabled = true
        contentView.addSubview(backdropImageView)
        createBackdropImageViewAnchor()
    }

    private func createPlayImageView() {
        playImageView.image = UIImage(systemName: Constants.playImageName)
        playImageView.tintColor = .orange
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playImageView)
        setupPlayImageViewAnchor()
    }

    private func createAvarageLabel() {
        avarageLabel.backgroundColor = .darkGray
        avarageLabel.textColor = .systemOrange
        avarageLabel.layer.cornerRadius = 5
        avarageLabel.layer.masksToBounds = true
        avarageLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        avarageLabel.textAlignment = .center
        avarageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avarageLabel)
        setupAvarageLabelAnchor()
    }

    private func createPosterImageView() {
        posterImageView.backgroundColor = .orange
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 5
        posterImageView.layer.shadowColor = UIColor.white.cgColor
        posterImageView.layer.masksToBounds = true
        contentView.addSubview(posterImageView)
        createImageViewAnchor()
    }

    private func createAboutMovieeLabel() {
        aboutMovieLabel.text = Constants.aboutMovieText
        aboutMovieLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        aboutMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(aboutMovieLabel)
        createAboutMovieLabelAnchor()
    }

    private func createDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
        createDescriptionLabelAnchor()
    }

    private func createCastLabel() {
        castLabel.text = Constants.castText
        castLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(castLabel)
        setupCastLabelAnchor()
    }

    private func createContainerView() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(conteinerView)
        setupContainerViewAnchor()
    }

    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(CastViewCell.self, forCellWithReuseIdentifier: Constants.collectionCellIdentifier)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        conteinerView.addSubview(collectionView ?? UICollectionView())
        setupCollectionViewAnchor(collectionView ?? UICollectionView())
    }

    private func createBackdropImageViewAnchor() {
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.leftAnchor.constraint(equalTo: leftAnchor),
            backdropImageView.rightAnchor.constraint(equalTo: rightAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 300),
            backdropImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }

    private func setupPlayImageViewAnchor() {
        playImageView.centerXAnchor.constraint(equalTo: backdropImageView.centerXAnchor).isActive = true
        playImageView.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor).isActive = true
        playImageView.widthAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 0.15).isActive = true
        playImageView.heightAnchor.constraint(equalTo: playImageView.widthAnchor).isActive = true
    }

    private func setupAvarageLabelAnchor() {
        NSLayoutConstraint.activate([
            avarageLabel.rightAnchor.constraint(equalTo: backdropImageView.rightAnchor, constant: -5),
            avarageLabel.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -15),
            avarageLabel.widthAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 0.15),
            avarageLabel.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 0.06)
        ])
    }

    private func createNameLabelAnchor() {
        NSLayoutConstraint.activate(
            [
                movieNameLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 20),
                movieNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                movieNameLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor, constant: 20),
            ]
        )
    }

    private func setupRuntimeLabelAnchor() {
        NSLayoutConstraint.activate([
            runtimeLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 5),
            runtimeLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 20),
            runtimeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            runtimeLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupBudgetLabelAnchor() {
        NSLayoutConstraint.activate([
            budgetLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor),
            budgetLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 20),
            budgetLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            budgetLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupRevenueLabelAnchor() {
        NSLayoutConstraint.activate([
            revenueLabel.topAnchor.constraint(equalTo: budgetLabel.bottomAnchor),
            revenueLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 20),
            revenueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            revenueLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupGenreLabelAnchor() {
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: revenueLabel.bottomAnchor),
            genreLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 20),
            genreLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            genreLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func createImageViewAnchor() {
        posterImageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 30)
            .isActive = true
        posterImageView.heightAnchor.constraint(equalTo: backdropImageView.heightAnchor, multiplier: 0.6)
            .isActive = true
        posterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor, constant: 180)
            .isActive = true
    }

    private func createAboutMovieLabelAnchor() {
        NSLayoutConstraint.activate([
            aboutMovieLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            aboutMovieLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        ])
    }

    private func createDescriptionLabelAnchor() {
        NSLayoutConstraint.activate(
            [
                descriptionLabel.topAnchor.constraint(equalTo: aboutMovieLabel.bottomAnchor, constant: 10),
                descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
                descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            ]
        )
    }

    private func setupCastLabelAnchor() {
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            castLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            castLabel.heightAnchor.constraint(equalToConstant: 30),

        ])
    }

    private func setupContainerViewAnchor() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 8),
            conteinerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            conteinerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            conteinerView.heightAnchor.constraint(equalToConstant: 140),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    private func setupCollectionViewAnchor(_ collectionView: UICollectionView) {
        collectionView.topAnchor.constraint(equalTo: conteinerView.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: conteinerView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: conteinerView.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor).isActive = true
    }

    private func getPosterImage(_ movie: MoviesDetail, _ viewModel: DescriptionViewModelProtocol) {
        guard let imagePath = movie.posterPath else { return }
        viewModel.fetchImage(url: imagePath) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
        }
    }

    private func getBackdropImage(_ movie: MoviesDetail, _ viewModel: DescriptionViewModelProtocol) {
        guard let imagePath = movie.backdropPath else { return }
        viewModel.fetchImage(url: imagePath) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.backdropImageView.image = UIImage(data: data)
            }
        }
    }

    private func movieDestribution(_ movie: MoviesDetail) {
        movieNameLabel.text = movie.title
        imdbId = movie.imdbId ?? ""
        descriptionLabel.text = "\(movie.overview)"
        avarageLabel.text = "⭐️\(movie.voteAverage)"
        runtimeLabel.text = Constants.runtimeText + "\(movie.runtime ?? Constants.zeroInt)" + " " + Constants.minutes
        budgetLabel.text = Constants.budgetText + "\(movie.budget ?? Constants.zeroInt) $"
        revenueLabel.text = Constants.revenueText + "\(movie.revenue ?? Constants.zeroInt) $"
        guard let genre = movie.genres?.first else { return }
        genreLabel.text = Constants.genreText + (genre.name ?? "")
    }

    @objc private func goWebControllerAction() {
        moveWebView?(imdbId)
    }
}

// MARK: - UICollectionViewDataSource

extension DescriptionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        descriptionViewModel?.casts?.count ?? Constants.zeroInt
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionCellIdentifier,
                for: indexPath
            ) as? CastViewCell,
            let cast = descriptionViewModel?.casts?[indexPath.row],
            let viewModel = descriptionViewModel
        else {
            return UICollectionViewCell()
        }
        cell.updateInfo(info: cast, viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DescriptionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 100, height: conteinerView.bounds.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.collectionViewLineSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.collectionViewLineSpacing
    }
}
