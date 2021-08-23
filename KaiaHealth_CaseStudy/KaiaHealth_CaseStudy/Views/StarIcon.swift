//
//  StarIcon.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

class StarIcon: UIButton {

    // MARK: Properties

    private var exercise: Exercise?

    private var starSelected: Bool = false {
        didSet {
            ExerciseManager.shared.setFavoriteStatus(starSelected, for: exercise)
        }
    }

    // MARK: Configure view

    func configure(with exercise: Exercise?) {
        self.exercise = exercise
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: Constants.Sizing.starIconHeight).isActive = true
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        addTarget(self, action: #selector(toggleFavoriteStatus), for: .touchUpInside)

        setStarImage(selected: ExerciseManager.shared.favoriteStatus(for: exercise))
    }

    private func setStarImage(selected: Bool) {
        if selected {
            setImage(UIImage(named: Constants.Images.starSelected), for: .normal)
        } else {
            setImage(UIImage(named: Constants.Images.starUnselected), for: .normal)
        }
    }

    // MARK: @objc selectors

    @objc
    func toggleFavoriteStatus(_ sender: UIButton) {
        starSelected = !starSelected
        setStarImage(selected: starSelected)
    }
}
