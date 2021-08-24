//
//  Constants.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

enum Constants {
    /// CGFloats used for constraints and other view configurations
    enum Sizing {
        /// CGFloat value set to 16
        static let viewMargins: CGFloat = 16
        /// CGFloat value set to 8
        static let interItemSpacing: CGFloat = 8
        /// CGFloat value set to 30
        static let starIconHeight: CGFloat = 30
        /// CGFloat value set to 16
        static let viewCornerRadius: CGFloat = 16
        /// CGFloat value set to 8
        static let buttonCornerRadius: CGFloat = 8
        /// CGFloat value set to 70
        static let tableViewFooterHeight: CGFloat = 64
    }

    /// Images that are not loaeded from API
    enum Images {
        static let exercisePlaceholder = "exercise_placeholder"
        static let starUnselected = "star_unselected"
        static let starSelected = "star_selected"
    }

    /// Colors used in the app
    enum Colors {
        static let lightGrayBackground = UIColor(red: 237/255, green: 240/255, blue: 245/255, alpha: 1)
    }
}
