//
//  Kaia+UIView.swift
//  Kaia_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

extension UIView {
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

    func addCenteredSubview(_ view: UIView, minimumMargin: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: minimumMargin),
            view.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: minimumMargin)
        ])
    }
}
