//
//  FavoritesManager.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/23/21.
//

import Foundation

class FavoritesManager {
    
    /// Toggles the boolean signifying whether a specific exercise has been favorited
    /// - Parameter exercise: exercise to favorite/unfavorite
    func setFavoriteStatus(_ status: Bool, for exerciseId: Int?) {
        guard let id = exerciseId else {
            return
        }

        UserDefaults.standard.setValue(status, forKey: String(id))
    }

    /// Fetches current favorite status of a given exercise
    /// - Parameter exercise: exercise for which to fetch favorite status
    /// - Returns: boolean signifying whether the given exercise is currently favorited
    func favoriteStatus(for id: Int) -> Bool {
        guard let favorited = UserDefaults.standard.value(forKey: String(id)) as? Bool else {
            return false
        }

        return favorited
    }
}
