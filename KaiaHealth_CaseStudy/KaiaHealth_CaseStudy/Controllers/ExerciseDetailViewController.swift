//
//  ExerciseDetailViewController.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    // MARK: Strings

    // Note: With more time, these strings should be localized
    private enum Strings {
        static let cancelTraining = "Training Abbrechen"
    }

    // MARK: Properties

    var exercise: Exercise

    private var starSelected: Bool = false {
        didSet {
            ExerciseManager.shared.setFavoriteStatus(starSelected, for: exercise)
        }
    }

    // MARK: UI elements

    private lazy var exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.Images.exercisePlaceholder)
        return imageView
    }()

    private lazy var starIcon = StarIcon()

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
        stackView.distribution = .fillProportionally
        stackView.alignment = .trailing
        return stackView
    }()

    // MARK: Initializers

    init(exercise: Exercise) {
        self.exercise = exercise
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addCenteredSubview(stackView, minimumMargin: Constants.Sizing.fullScreenImageInsets)
        loadImage()
        starIcon.configure(with: exercise)
    }

    // MARK: Fetch data

    func loadImage() {
        ExerciseManager.shared.loadImage(stringURL: exercise.coverImageUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.exerciseImageView.image = image
            }
        }
    }

    // MARK: @objc selectors

    @objc
    func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
