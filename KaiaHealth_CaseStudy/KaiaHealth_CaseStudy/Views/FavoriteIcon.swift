//
//  FavoriteIcon.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

protocol FavoriteIconDelegate: AnyObject {
    func setFavoriteStatus(to status: Bool)
}

class FavoriteIcon: UIButton {

    // MARK: Properties

    weak var delegate: FavoriteIconDelegate?

    private var favorited: Bool = false {
        didSet {
            setStarImage(selected: favorited)
        }
    }

    // MARK: Configure view

    func configure(selected: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: Constants.Sizing.starIconHeight).isActive = true
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        addTarget(self, action: #selector(toggleFavoriteStatus), for: .touchUpInside)
        
        favorited = selected
    }

    private func setStarImage(selected: Bool) {
        if selected {
            setImage(UIImage(named: Constants.Images.starSelected), for: .normal)
        } else {
            setImage(UIImage(named: Constants.Images.starUnselected), for: .normal)
        }
    }

    // MARK: @objc selectors

    @objc func toggleFavoriteStatus(_ sender: UIButton) {
        favorited = !favorited
        delegate?.setFavoriteStatus(to: favorited)
    }
}
