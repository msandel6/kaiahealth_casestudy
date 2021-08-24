//
//  KaiaHealth_CaseStudyExerciseCellTests.swift
//  KaiaHealth_CaseStudyTests
//
//  Created by Muriel Sandel on 8/22/21.
//

import XCTest
@testable import KaiaHealth_CaseStudy

class KaiaHealth_CaseStudyExerciseCellTests: XCTestCase {

    // MARK: Properties

    let favoritesManager = MockFavoritesManager()
    var cell: ExerciseCell?

    let exercise1 = Exercise(id: 0, name: "Exercise 1", coverImageUrl: "test.image.com")
    let exercise2 = Exercise(id: 1, name: "Exercise 2", coverImageUrl: "test.image.com")
    let exercise3 = Exercise(id: 2, name: "Exercise 3", coverImageUrl: "test.image.com")

    // MARK: Setup

    override func setUp() {
        super.setUp()
        cell = ExerciseCell(favoritesManager: favoritesManager)
    }

    // MARK: Teardown

    override func tearDown() {
        cell = nil
        favoritesManager.favoritesSettings.removeAll()
        super.tearDown()
    }

    // MARK: Test functions

    // TODO: Given more time, make sure unit tests don't try to load images from API
    func testExerciseCell_setFavoritesStatus() {
        guard let cell = cell else { return }
        cell.configure(with: exercise1)
        cell.setFavoriteStatus(to: false)
        XCTAssertNil(favoritesManager.favoritesSettings[exercise1.id])

        XCTAssertNil(favoritesManager.favoritesSettings[exercise2.id])
        cell.configure(with: exercise2)
        cell.setFavoriteStatus(to: true)
        XCTAssertNotNil(favoritesManager.favoritesSettings[exercise2.id])

        XCTAssertNil(favoritesManager.favoritesSettings[exercise3.id])
        cell.configure(with: exercise3)
        cell.setFavoriteStatus(to: true)
        XCTAssertNotNil(favoritesManager.favoritesSettings[exercise3.id])

        cell.configure(with: exercise2)
        cell.setFavoriteStatus(to: false)
        XCTAssertNil(favoritesManager.favoritesSettings[exercise2.id])
    }
}

class MockFavoritesManager: FavoritesManager {
    var favoritesSettings: [Int : Bool] = [:]

    override func favoriteStatus(for id: Int) -> Bool {
        return favoritesSettings[id] ?? false
    }

    override func setFavoriteStatus(_ isFavorite: Bool, for exerciseId: Int?) {
        guard let exerciseId = exerciseId else { return }
        if isFavorite {
            favoritesSettings[exerciseId] = isFavorite
        } else {
            favoritesSettings.removeValue(forKey: exerciseId)
        }
    }
}
