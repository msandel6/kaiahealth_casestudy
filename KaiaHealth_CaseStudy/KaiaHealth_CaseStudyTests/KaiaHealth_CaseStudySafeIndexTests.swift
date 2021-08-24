//
//  KaiaHealth_CaseStudySafeIndexTests.swift
//  KaiaHealth_CaseStudyTests
//
//  Created by Muriel Sandel on 8/24/21.
//

@testable import KaiaHealth_CaseStudy
import XCTest

class KaiaHealth_CaseStudySafeIndexTests: XCTestCase {

    private let array = [1, 29, 233, 42, 15]

    func testValidIndices() {
        XCTAssertNotNil(array[safe: 0])
        XCTAssertNotNil(array[safe: 1])
        XCTAssertNotNil(array[safe: 2])
        XCTAssertNotNil(array[safe: 3])
        XCTAssertNotNil(array[safe: 4])
    }

    func testInvalidIndices() {
        XCTAssertNil(array[safe: -1])
        XCTAssertNil(array[safe: 5])
        XCTAssertNil(array[safe: 100])
    }
}
