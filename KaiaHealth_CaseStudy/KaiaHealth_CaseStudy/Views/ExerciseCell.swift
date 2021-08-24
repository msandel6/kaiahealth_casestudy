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
    private let favoritesManager: FavoritesManager

    // MARK: Reuse identifier

    static let reuseIdentifier = "ExerciseCell"

    // MARK: UI elements

    private lazy var favoriteIcon: FavoriteIcon = {
        let icon = FavoriteIcon()
        icon.addTarget(self, action: #selector(setFavoriteStatus(to:)), for: .touchUpInside)
        return icon
    }()

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
            favoriteIcon
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

    init(favoritesManager: FavoritesManager = FavoritesManager()) {
        self.favoritesManager = favoritesManager
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        favoritesManager = FavoritesManager()

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
        thumbnailView.image = UIImage(named: Constants.Images.exercisePlaceholder)
    }

    // MARK: Configure cell

    func configure(with exercise: Exercise) {
        self.exercise = exercise
        label.text = exercise.name
        thumbnailView.loadImage(stringURL: exercise.coverImageUrl)
        configureFavoriteIcon()
    }

    private func configureFavoriteIcon() {
        guard let exercise = exercise else { return }
        favoriteIcon.configure(isFavorite: favoritesManager.favoriteStatus(for: exercise.id))
    }

    // MARK: @objc selectors
    
    @objc func setFavoriteStatus(to isFavorite: Bool) {
        guard let exercise = exercise else { return }
        favoritesManager.setFavoriteStatus(isFavorite,
                                           for: exercise.id)
        configureFavoriteIcon()
    }
}
