//
//  ExerciseCell.swift
//  Kaia_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

class ExerciseCell: UITableViewCell {

    // MARK: Properties

    private var exercise: Exercise?
    private let favoritesManager = FavoritesManager()

    // MARK: Reuse identifier

    static let reuseIdentifier = "ExerciseCell"

    // MARK: UI elements

    lazy var starIcon = FavoriteIcon()

    private lazy var thumbnailView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = Constants.Sizing.viewCornerRadius
        view.layer.masksToBounds = true
        view.image = UIImage(named: Constants.Images.exercisePlaceholder)
        view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            thumbnailView,
            label,
            starIcon
        ])

        stackView.axis = .horizontal
        stackView.spacing = Constants.Sizing.interItemSpacing
        stackView.alignment = .center
        stackView.backgroundColor = .white
        return stackView
    }()

    private lazy var tileView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.Sizing.viewCornerRadius
        view.layer.masksToBounds = true
        view.addFilledSubview(stackView, margin: Constants.Sizing.viewMargins)
        return view
    }()

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        contentView.addFilledSubview(tileView, margin: Constants.Sizing.interItemSpacing)
        thumbnailView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func prepareForReuse() {
        label.text = nil
        starIcon = FavoriteIcon()
        thumbnailView.image = UIImage(named: Constants.Images.exercisePlaceholder)
    }

    // MARK: Configure cell

    func configure(with exercise: Exercise) {
        self.exercise = exercise
        label.text = exercise.name
        loadImage(stringURL: exercise.coverImageUrl)
        setupStarIcon()
    }

    private func setupStarIcon() {
        guard let exercise = exercise else { return }

        starIcon.configure(selected: favoritesManager.favoriteStatus(for: exercise.id))
        starIcon.delegate = self
    }

    // MARK: Fetch image data

    private func loadImage(stringURL: String?) {
        ExerciseManager.shared.loadImage(stringURL: stringURL) { [weak self] image in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.thumbnailView.image = image
            }
        }
    }
}

extension ExerciseCell: FavoriteIconDelegate {
    func setFavoriteStatus(to status: Bool) {
        favoritesManager.setFavoriteStatus(status,
                                                 for: exercise?.id)
    }
}
