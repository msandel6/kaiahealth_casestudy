//
//  ExerciseOverviewViewController.swift
//  Kaia_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

class ExerciseOverviewViewController: UIViewController {

    // MARK: Strings

    // TODO: With more time, these strings should be localized
    private enum Strings {
        static let title = "Exercises"
    }

    // MARK: Properties

    private let exerciseManager: ExerciseManager
    private let favoritesManager: FavoritesManager

    // MARK: UI elements

    private let tableView = UITableView()
    private let tableFooterView = ExerciseTableViewFooter()

    private lazy var dataSource: UITableViewDiffableDataSource<Section, ExerciseItem> = makeDataSource()

    // MARK: Initializers

    init(exerciseManager: ExerciseManager = ExerciseManager(),
         favoritesManager: FavoritesManager = FavoritesManager()) {
        self.exerciseManager = exerciseManager
        self.favoritesManager = favoritesManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.lightGrayBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Strings.title

        setupTableView()
        loadExercises()
    }

    // MARK: Configure UI elements
    
    private func setupTableView() {
        view.addFilledSubview(tableView)

        tableView.register(ExerciseCell.self, forCellReuseIdentifier: ExerciseCell.reuseIdentifier)
        tableView.dataSource = dataSource
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        setupTableFooterView()
    }

    private func setupTableFooterView() {
        tableFooterView.frame.size.height = Constants.Sizing.tableViewFooterHeight
        tableFooterView.startTrainingButton.addTarget(self, action: #selector(startTraining), for: .touchUpInside)
        tableFooterView.startTrainingButton.isHidden = true
        tableView.tableFooterView = tableFooterView
    }

    // MARK: DiffableDataSource

    private func makeDataSource() -> UITableViewDiffableDataSource<Section, ExerciseItem> {
        let dataSource = UITableViewDiffableDataSource<Section, ExerciseItem>(tableView: tableView) { tableView, indexPath, exerciseWithFavorites in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseCell.reuseIdentifier, for: indexPath) as? ExerciseCell else {
                assertionFailure("Programmer Error!")
                return UITableViewCell()
            }

            cell.configure(with: exerciseWithFavorites.exercise)
            return cell
        }

        return dataSource
    }

    // MARK: Fetch data

    private func loadExercises() {
        exerciseManager.loadExercises() { [weak self] exercises in
            DispatchQueue.main.async {
                self?.updateDataSource(with: exercises)
                if !exercises.isEmpty {
                    self?.tableFooterView.startTrainingButton.isHidden = false
                } else {
                    // TODO: Add label, alert, or refresh button
                }
            }
        }
    }

    private func updateDataSource(with exercises: [Exercise]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ExerciseItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(exercises.map {
            ExerciseItem(exercise: $0,
                         isFavorite: favoritesManager.favoriteStatus(for: $0.id))
        })

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Training

    @objc private func startTraining() {
        let excercies = dataSource.snapshot().itemIdentifiers.map { $0.exercise }
        let trainingViewController = TrainingViewController(exercises: excercies)
        trainingViewController.delegate = self
        trainingViewController.modalPresentationStyle = .fullScreen
        present(trainingViewController, animated: true)
    }
}

extension ExerciseOverviewViewController: TrainingViewControllerDelegate {
    func trainingViewControllerDidRequestDismissal(_ trainingViewController: TrainingViewController) {
        // TODO: I don't love this - given more time, find a better way to do this
        updateDataSource(with: self.dataSource.snapshot().itemIdentifiers.map { $0.exercise })
        trainingViewController.dismiss(animated: true)
    }
}
