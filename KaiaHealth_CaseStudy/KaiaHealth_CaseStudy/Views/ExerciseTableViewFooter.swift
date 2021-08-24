//
//  ExerciseTableViewFooter.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/23/21.
//

import UIKit

class ExerciseTableViewFooter: UIView {

    // MARK: Strings

    private enum Strings {
        // Note: With more time, these strings should be localized
        static let startTraining = "Start Training"
    }

    // MARK: UI elements

    private(set) lazy var startTrainingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Sizing.buttonCornerRadius
        button.layer.masksToBounds = true

        button.setTitle(Strings.startTraining, for: .normal)
        button.backgroundColor = .systemGray
        return button
    }()

    // MARK: Initailizer

    init() {
        super.init(frame: .zero)
        addCenteredSubview(startTrainingButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
