//
//  Kaia+UIImageView.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/24/21.
//

import UIKit

extension UIImageView {

    /// Loads an image from a URL
    /// - Parameters:
    ///   - stringURL: a String representation of the image URL
    ///   - completion: closure to be executed once request is completed
    func loadImage(stringURL: String?) {
        guard let stringURL = stringURL,
              let url = URL(string: stringURL) else {
            return
        }

        let networkManager = NetworkManager()

        networkManager.loadImage(url) { [weak self] loadedImage in
            self?.image = loadedImage
        }
    }
}
