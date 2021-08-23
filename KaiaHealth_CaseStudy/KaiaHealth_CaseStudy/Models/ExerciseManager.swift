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

    // MARK: Shared instance

    static let shared = ExerciseManager()

    // MARK: Load exercise data

    func loadExercises(completion: @escaping ([Exercise]?) -> Void) {
        guard let url = URL(string: URLs.exerciseURL) else {
            completion(nil)
            return
        }

        NetworkManager.shared.performRequest(for: [Exercise].self, with: url) { result in
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

        NetworkManager.shared.loadImage(url) { image in
            completion(image)
        }
    }

    // MARK: Persist user preferances

    func setFavoriteStatus(_ status: Bool, for exercise: Exercise?) {
        guard let exercise = exercise else {
            return
        }

        UserDefaults.standard.setValue(status, forKey: String(exercise.id))
    }

    func favoriteStatus(for exercise: Exercise?) -> Bool {
        guard let exercise = exercise,
            let favorited = UserDefaults.standard.value(forKey: String(exercise.id)) as? Bool else {
            return false
        }

        return favorited
    }
}
