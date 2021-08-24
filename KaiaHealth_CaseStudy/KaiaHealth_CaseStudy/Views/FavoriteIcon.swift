//
//  FavoriteIcon.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

class FavoriteIcon: UIButton {

    // MARK: Configure view

    func configure(isFavorite: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: Constants.Sizing.starIconHeight).isActive = true
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        setFavoritesIcon(selected: isFavorite)
    }

    private func setFavoritesIcon(selected: Bool) {
        if selected {
            setImage(UIImage(named: Constants.Images.starSelected), for: .normal)
        } else {
            setImage(UIImage(named: Constants.Images.starUnselected), for: .normal)
        }
    }
}
