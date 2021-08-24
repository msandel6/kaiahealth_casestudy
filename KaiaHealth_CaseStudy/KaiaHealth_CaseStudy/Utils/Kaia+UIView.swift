//
//  Kaia+UIView.swift
//  Kaia_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

extension UIView {
    /// Adds a subview with equal margins to parent view on all sides
    /// - Parameters:
    ///   - view: view to be added as subview
    ///   - margin: margins on all sides of subview (defaults to 0)
    func addFilledSubview(_ view: UIView, margin: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            view.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin)
        ])
    }

    /// Adds a subview that is centered in the parent view
    /// - Parameters:
    ///   - view: view to be added as subview
    func addCenteredSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
