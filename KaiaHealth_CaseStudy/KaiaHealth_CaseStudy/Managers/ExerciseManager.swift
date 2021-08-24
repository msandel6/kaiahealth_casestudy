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

    // MARK: Load exercise data

    /// Loads exercises from the API
    /// - Parameter completion: closure to be executed once request is completed
    /// - Returns: an array of type `[Exercise]`
    func loadExercises(completion: @escaping ([Exercise]) -> ()) {
        guard let url = URL(string: URLs.exerciseURL) else {
            // TODO: Error handling
            completion([])
            return
        }

        networkManager.performRequest(for: [Exercise].self, with: url) { result in
            switch result {
            case .success(let exercises):
                completion(exercises)
            case .failure:
                // TODO: Error handling
                completion([])
            }
        }
    }
}
