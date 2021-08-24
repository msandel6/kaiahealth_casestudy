//
//  KaiaHealth_CaseStudyFavoritesManagerTests.swift
//  KaiaHealth_CaseStudyTests
//
//  Created by Muriel Sandel on 8/22/21.
//

import XCTest
@testable import KaiaHealth_CaseStudy

class KaiaHealth_CaseStudyFavoritesManagerTests: XCTestCase {

    var favoritesManager = MockFavoritesManager()

    override func setUp() {
        super.setUp()

        favoritesManager.favoritesSettings = [
            0 : false,
            1 : false,
            2 : true,
            3 : false
        ]
    }

    func testFavoritesManager_favoriteStatus() {
        XCTAssertFalse(favoritesManager.favoriteStatus(for: 0))
        XCTAssertFalse(favoritesManager.favoriteStatus(for: 1))
        XCTAssertTrue(favoritesManager.favoriteStatus(for: 2))
        XCTAssertFalse(favoritesManager.favoriteStatus(for: 3))
    }

    func testFavoritesManager_setFavoriteStatus_updateExisting() {
        favoritesManager.setFavoriteStatus(true, for: 0)
        XCTAssertTrue(favoritesManager.favoriteStatus(for: 0))

        favoritesManager.setFavoriteStatus(false, for: 2)
        XCTAssertFalse(favoritesManager.favoriteStatus(for: 2))
    }

    func testFavoritesManager_setFavoritesStatus_addNew() {
        favoritesManager.setFavoriteStatus(true, for: 6)
        XCTAssertTrue(favoritesManager.favoriteStatus(for: 6))

        favoritesManager.setFavoriteStatus(false, for: 100)
        XCTAssertFalse(favoritesManager.favoriteStatus(for: 100))

    }
}

class MockFavoritesManager: FavoritesManager {
    var favoritesSettings: [Int : Bool] = [:]

    override func favoriteStatus(for id: Int) -> Bool {
        return favoritesSettings[id] ?? false
    }

    override func setFavoriteStatus(_ status: Bool, for exerciseId: Int?) {
        guard let exerciseId = exerciseId else { return }
        favoritesSettings[exerciseId] = status
    }
}
