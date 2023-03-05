// MovieListViewController.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

/// Экран выбора фильмов
final class MovieListViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let titleText = "Movie"
        static let listCellIdentifier = "listCell"
        static let popularSegmentName = "Popular"
        static let topSegmentName = "Top"
        static let newSegmentName = "New"
        static let alertTitle = "Внимание"
        static let zeroInt = 0
        static let propsError = "Ошибка в Props"
        static let apikeyPlaceholder = "Введите Apikey"
        static let okButtonText = "OK"
        static let alertMessage = "Введите ключ"
        static let emptyString = ""
    }

    // MARK: - Private Visual Components

    private let tableView = UITableView()
    private let segmentControl: UISegmentedControl = {
        let segmentControl =
            UISegmentedControl(items: [
                Constants.popularSegmentName,
                Constants.topSegmentName,
                Constants.newSegmentName
            ])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.selectedSegmentTintColor = .systemYellow
        return segmentControl
    }()

    private lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    // MARK: - Public Properties

    var movieListViewModel: MovieListViewModelProtocol?
    var toDescriptionModule: IntHandler?

    // MARK: - Life Cycles

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        switch movieListViewModel?.props {
        case .initial:
            setupUI()
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
            tableView.isHidden = true
        case .success:
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        case let .failure(error):
            showAlert(title: Constants.alertTitle, message: error.localizedDescription)
        default:
            showAlert(title: Constants.alertTitle, message: Constants.propsError)
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        apiKeyBind()
        movieListViewModel?.configureAlertHandler()
        layoutBind()
        createSegmentControl()
        fetchData()
        createTableView()
        createViewConfiguration()
        setupActivityView()
        showCoreDataErrorAlert()
    }

    private func fetchData() {
        movieListViewModel?.fetchData()
    }

    private func layoutBind() {
        movieListViewModel?.layoutHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.view.setNeedsLayout()
            }
        }
    }

    private func apiKeyBind() {
        movieListViewModel?.apiKeyHandler = { [weak self] in
            guard let self = self else { return }
            self.showApiKeyAlert()
        }
    }

    private func showCoreDataErrorAlert() {
        movieListViewModel?.showCoreDataError = { [weak self] error in
            self?.showAlert(title: Constants.alertTitle, message: error)
        }
    }

    private func createViewConfiguration() {
        view.backgroundColor = .systemBackground
        title = Constants.titleText
        navigationController?.navigationBar.tintColor = .systemOrange
    }

    private func createTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieListViewCell.self, forCellReuseIdentifier: Constants.listCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        createTableViewAnchor()
    }

    private func setupActivityView() {
        view.addSubview(activityIndicatorView)
        createActivityViewAnchor()
    }

    private func createSegmentControl() {
        segmentControl.backgroundColor = .systemOrange
        segmentControl.addTarget(self, action: #selector(segmentControlAction), for: .valueChanged)
        view.addSubview(headerView)
        headerView.addSubview(segmentControl)
        createSegmentControlAnchor()
        createHeaderAnchor()
    }

    private func createSegmentControlAnchor() {
        segmentControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1).isActive = true
    }

    private func createHeaderAnchor() {
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }

    private func createTableViewAnchor() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func createActivityViewAnchor() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func showApiKeyAlert() {
        let alertController = UIAlertController(
            title: Constants.alertTitle,
            message: Constants.alertMessage,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: Constants.okButtonText, style: .destructive) { _ in
            guard let text = alertController.textFields?.first?.text else { return }
            self.movieListViewModel?.saveKeychainValue(text: text)
            self.fetchData()
        }
        alertController.addAction(alertAction)
        alertController.addTextField { $0.placeholder = Constants.apikeyPlaceholder }
        present(alertController, animated: true)
    }

    @objc private func segmentControlAction() {
        movieListViewModel?.segmentControlAction(index: segmentControl.selectedSegmentIndex)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case let .success(movie) = movieListViewModel?.props {
            return movie.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.listCellIdentifier,
                for: indexPath
            ) as? MovieListViewCell,
            let viewModel = movieListViewModel
        else {
            return UITableViewCell()
        }
        if case let .success(movie) = movieListViewModel?.props {
            cell.configure(movie[indexPath.row], viewModel: viewModel)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case let .success(movies) = movieListViewModel?.props {
            let id = movies[indexPath.row].id
            toDescriptionModule?(id)
        }
    }
}
