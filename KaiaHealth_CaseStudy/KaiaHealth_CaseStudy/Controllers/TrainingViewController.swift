//
//  TrainingViewController.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

protocol TrainingViewControllerDelegate: AnyObject {
    func dismissTraining()
}

class TrainingViewController: UIViewController {

    // MARK: Strings

    private enum Strings {
        // Note: With more time, these strings should be localized
        static let cancelTraining = "Cancel Training"
    }

    // MARK: Properties

    private let exercises: [Exercise]
    private let favoritesManager = FavoritesManager()
    private var currentExerciseIndex = 0

    private var timer: Timer?

    weak var delegate: TrainingViewControllerDelegate?

    // MARK: UI elements

    private lazy var exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.Images.exercisePlaceholder)
        return imageView
    }()

    private lazy var starIcon: FavoriteIcon = {
        let starIcon = FavoriteIcon()
        starIcon.delegate = self

        if let exercise = exercises[safe: currentExerciseIndex] {
            starIcon.configure(selected: favoritesManager.favoriteStatus(for: exercise.id))
        }
        
        return starIcon
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.cancelTraining, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cancelButton,
            exerciseImageView,
            starIcon
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .trailing
        return stackView
    }()

    // MARK: Initializers

    init(exercises: [Exercise]) {
        self.exercises = exercises
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
        view.addFilledSubview(stackView, margin: Constants.Sizing.viewMargins)
        startExerciseTimer()
        loadImage(stringURL: exercises[currentExerciseIndex].coverImageUrl)
    }

    // MARK: Private instance methods

    private func startExerciseTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.currentExerciseIndex += 1
            if let exercise = self.exercises[safe: self.currentExerciseIndex] {
                self.starIcon.configure(selected: self.favoritesManager.favoriteStatus(for: exercise.id))
                self.loadImage(stringURL: exercise.coverImageUrl)
            } else {
                timer.invalidate()
                self.dismiss(animated: true)
            }
        }
    }

    private func loadImage(stringURL: String?) {
        ExerciseManager.shared.loadImage(stringURL: stringURL) { image in
            DispatchQueue.main.async {
                self.exerciseImageView.image = image
            }
        }
    }

    // MARK: @objc selectors

    @objc func cancel(_ sender: UIButton) {
        delegate?.dismissTraining()
    }
}

extension TrainingViewController: FavoriteIconDelegate {
    func setFavoriteStatus(to status: Bool) {
        guard let exercise = exercises[safe: currentExerciseIndex] else { return }
        favoritesManager.setFavoriteStatus(status, for: exercise.id)
    }
}
