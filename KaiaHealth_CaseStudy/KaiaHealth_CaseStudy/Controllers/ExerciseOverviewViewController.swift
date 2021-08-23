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

    var exercises: [Exercise] = []

    // MARK: UI elements

    let tableView = UITableView()

    private lazy var dataSource: UITableViewDiffableDataSource<Section, Exercise> = makeDataSource()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.lightGrayBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Exercises"

        setupTableView()
        loadExercises()
    }

    // MARK: Configure UI elements
    
    private func setupTableView() {
        view.addFilledSubview(tableView)

        tableView.delegate = self
        tableView.register(ExerciseCell.self, forCellReuseIdentifier: ExerciseCell.reuseIdentifier)
        tableView.dataSource = dataSource
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }

    // MARK: DiffableDataSource

    func makeDataSource() -> UITableViewDiffableDataSource<Section, Exercise> {
        let dataSource = UITableViewDiffableDataSource<Section, Exercise>(tableView: tableView) { tableView, indexPath, exercise in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseCell.reuseIdentifier, for: indexPath) as? ExerciseCell else {
                assertionFailure("Programmer Error!")
                return UITableViewCell()
            }

            cell.configure(with: exercise)
            return cell
        }

        return dataSource
    }

    // MARK: Fetch data

    func loadExercises() {
        ExerciseManager.shared.loadExercises() { [weak self] exercises in
            var snapshot = NSDiffableDataSourceSnapshot<Section, Exercise>()
            guard let exercises = exercises else {
                // TODO: Add error handling
                self?.exercises = []
                return
            }
            snapshot.appendSections([.main])
            snapshot.appendItems(exercises)
            self?.exercises = exercises
            self?.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - UITableViewDelegate

extension ExerciseOverviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let exercise = exercises[safe: indexPath.row] else {
            return
        }

        let detailViewController = ExerciseDetailViewController(exercise: exercise)
        detailViewController.modalPresentationStyle = .fullScreen
        present(detailViewController, animated: true)
    }
}
