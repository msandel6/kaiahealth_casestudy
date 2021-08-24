//
//  ExerciseTableViewFooter.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/23/21.
//

import UIKit

protocol ExerciseTableViewFooterDelegate: AnyObject {
    func startTraining()
}

class ExerciseTableViewFooter: UIView {

    // MARK: Strings

    private enum Strings {
        // Note: With more time, these strings should be localized
        static let startTraining = "Start Training"
    }

    // MARK: Delegate

    weak var delegate: ExerciseTableViewFooterDelegate?

    // MARK: UI elements

    private lazy var startTrainingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Sizing.buttonCornerRadius
        button.layer.masksToBounds = true

        button.setTitle(Strings.startTraining, for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(startTraining), for: .touchUpInside)
        return button
    }()

    // MARK: Configure view

    func configure() {
        frame.size.height = Constants.Sizing.tableViewFooterHeight
        addFilledSubview(startTrainingButton, margin: Constants.Sizing.interItemSpacing)
    }

    // MARK: @objc selectors

    @objc func startTraining(_ sender: UIButton) {
        delegate?.startTraining()
    }
}
