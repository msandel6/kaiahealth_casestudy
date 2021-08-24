//
//  TrainingViewController.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

protocol TrainingViewControllerDelegate: AnyObject {
    func trainingViewControllerDidRequestDismissal(_ trainingViewController: TrainingViewController)
}

class TrainingViewController: UIViewController {

    // MARK: Strings

    // Note: With more time, these strings should be localized
    private enum Strings {
        static let cancelTraining = "Cancel Training"
    }

    // MARK: Properties

    private let exercises: [Exercise]
    private let favoritesManager: FavoritesManager
    private var currentExerciseIndex = 0
    private var timer: Timer?

    private var currentExercise: Exercise? {
        return self.exercises[safe: self.currentExerciseIndex]
    }

    weak var delegate: TrainingViewControllerDelegate?

    // MARK: UI elements

    private lazy var exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.Images.exercisePlaceholder)
        return imageView
    }()

    private lazy var favoriteIcon: FavoriteIcon = {
        let favoriteIcon = FavoriteIcon()
        if let exercise = currentExercise {
            favoriteIcon.configure(isFavorite: favoritesManager.favoriteStatus(for: exercise.id))
        }
        favoriteIcon.addTarget(self, action: #selector(setFavoriteStatus(to:)), for: .touchUpInside)
        return favoriteIcon
    }()

    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle(Strings.cancelTraining, for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return cancelButton
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cancelButton,
            exerciseImageView,
            favoriteIcon
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .trailing
        return stackView
    }()

    // MARK: Initializers

    init(exercises: [Exercise],
         favoritesManager: FavoritesManager = FavoritesManager()) {
        self.exercises = exercises
        self.favoritesManager = favoritesManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Denitializers

    deinit {
        timer?.invalidate()
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        startExerciseTimer()
        exerciseImageView.loadImage(stringURL: currentExercise?.coverImageUrl)
        setupStackView()
    }

    // MARK: Private instance methods

    private func setupStackView() {
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Sizing.tableViewFooterHeight),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.Sizing.tableViewFooterHeight),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Sizing.viewMargins),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Sizing.viewMargins)
        ])
    }

    private func configureFavoriteIcon() {
        guard let exercise = currentExercise else { return }
        favoriteIcon.configure(isFavorite: favoritesManager.favoriteStatus(for: exercise.id))
    }

    // TODO: Break this logic into its own manager given more time
    private func startExerciseTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.currentExerciseIndex += 1
            if let exercise = self.currentExercise {
                self.favoriteIcon.configure(isFavorite: self.favoritesManager.favoriteStatus(for: exercise.id))
                self.exerciseImageView.loadImage(stringURL: exercise.coverImageUrl)
            } else {
                timer.invalidate()
                self.delegate?.trainingViewControllerDidRequestDismissal(self)
            }
        }
    }

    // MARK: @objc selectors

    @objc func cancel(_ sender: UIButton) {
        delegate?.trainingViewControllerDidRequestDismissal(self)
    }

    @objc func setFavoriteStatus(to isFavorite: Bool) {
        guard let exercise = currentExercise else { return }
        favoritesManager.setFavoriteStatus(isFavorite,
                                           for: exercise.id)
        configureFavoriteIcon()
    }
}
