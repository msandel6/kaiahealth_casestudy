//
//  ExerciseManager.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

class ExerciseManager {

    // MARK: URLs

    private enum URLs {
        static let exerciseURL = "https://jsonblob.com/api/jsonBlob/d92ee4cd-dff6-11eb-a8ab-05b78a9f1668"
    }

    // MARK: Properties

    let networkManager = NetworkManager()

    // MARK: Shared instance

    static let shared = ExerciseManager()

    // MARK: Load exercise data

    func loadExercises(completion: @escaping ([Exercise]?) -> ()) {
        guard let url = URL(string: URLs.exerciseURL) else {
            completion(nil)
            return
        }

        networkManager.performRequest(for: [Exercise].self, with: url) { result in
            switch result {
            case .success(let exercises):
                completion(exercises)
            case .failure:
                completion(nil)
            }
        }
    }

    func loadImage(stringURL: String?, completion: @escaping (UIImage?) -> Void) {
        guard let stringURL = stringURL,
              let url = URL(string: stringURL) else {
            completion(nil)
            return
        }

        networkManager.loadImage(url) { image in
            completion(image)
        }
    }
}
