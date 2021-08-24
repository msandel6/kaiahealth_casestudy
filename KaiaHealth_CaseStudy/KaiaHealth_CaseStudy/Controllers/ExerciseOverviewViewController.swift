//
//  ExerciseOverviewViewController.swift
//  Kaia_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

class ExerciseOverviewViewController: UIViewController {

    // MARK: Strings

    // Note: With more time, these strings should be localized
    private enum Strings {
        static let title = "Exercises"
    }

    // MARK: Properties

    private var exercises: [Exercise] = []
    private let favoritesManager = FavoritesManager()

    // MARK: UI elements

    private let tableView = UITableView()

    private lazy var dataSource: UITableViewDiffableDataSource<Section, ExerciseWithFavorites> = makeDataSource()

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
        let tableFooterView = ExerciseTableViewFooter()
        tableFooterView.delegate = self
        tableFooterView.configure()
        tableView.tableFooterView = tableFooterView
    }

    // MARK: DiffableDataSource

    private func makeDataSource() -> UITableViewDiffableDataSource<Section, ExerciseWithFavorites> {
        let dataSource = UITableViewDiffableDataSource<Section, ExerciseWithFavorites>(tableView: tableView) { tableView, indexPath, exerciseWithFavorites in
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
        #warning("You should probably inject this somehow. (Maybe default init parameter so theoretically could be tested")
        ExerciseManager.shared.loadExercises() { [weak self] exercises in
            guard let self = self,
                  let exercises = exercises else {
                // TODO: Add error handling
                return
            }

            self.exercises = exercises
            self.updateDataSource()
        }
    }

    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ExerciseWithFavorites>()
        snapshot.appendSections([.main])
        snapshot.appendItems(exercises.map {
                                ExerciseWithFavorites(exercise: $0,
                                                      favorited: favoritesManager.favoriteStatus(for: $0.id))
        })
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ExerciseOverviewViewController: ExerciseTableViewFooterDelegate {
    func startTraining() {
        let trainingViewController = TrainingViewController(exercises: exercises)
        trainingViewController.delegate = self
        trainingViewController.modalPresentationStyle = .fullScreen
        present(trainingViewController, animated: true)
    }
}

extension ExerciseOverviewViewController: TrainingViewControllerDelegate {
    func dismissTraining() {
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.updateDataSource()
        }
    }
}
