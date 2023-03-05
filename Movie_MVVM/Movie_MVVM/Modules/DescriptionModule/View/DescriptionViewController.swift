// DescriptionViewController.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

/// Экран описания фильмов
final class DescriptionViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let cellIdentifier = "descriptionCell"
        static let alertTitle = "Внимание"
    }

    private enum CellType {
        case descriptionCell
    }

    // MARK: - Private Visual Components

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()

    // MARK: - Public Properties

    var descriptionViewModel: DescriptionViewModelProtocol?
    var moveWebView: StringHandler?

    // MARK: - Private Properties

    private let cellTypes: [CellType] = [.descriptionCell]

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        configureView()
        createTableView()
        createRefreshControl()
        fetchData()
        bind()
        showError()
    }

    private func configureView() {
        view.backgroundColor = .systemBackground
    }

    private func fetchData() {
        descriptionViewModel?.fetchData()
        descriptionViewModel?.fetchCasts()
    }

    private func createRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshedAction), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func createTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DescriptionViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
        createTableViewAnchor()
    }

    private func createTableViewAnchor() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func bind() {
        descriptionViewModel?.updateViewHandler = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func showError() {
        descriptionViewModel?.errorHandler = { [weak self] error in
            self?.showAlert(title: Constants.alertTitle, message: error)
        }
    }

    @objc private func refreshedAction() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource

extension DescriptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.cellIdentifier,
                for: indexPath
            ) as? DescriptionViewCell,
            let movie = descriptionViewModel?.movieDetail,
            let viewModel = descriptionViewModel
        else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(movie, viewModel)
        cell.moveWebView = moveWebView
        return cell
    }
}

// MARK: - PresentViewControllerDelegate

extension DescriptionViewController: PresentViewControllerDelegate {
    func goToVC(param: UIViewController) {
        present(param, animated: true)
    }
}
