//
//  ArrayExtension.swift
//  NewviesTests
//
//  Created by Jay Jac on 3/24/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import Newvies

class ArrayExtension: XCTestCase {


    private struct MockMovie: MovieOrTVShow {
        var overview: String?
        var poster_path: String?
        var vote_count: Double?
        var vote_average: Double?
    }

    func testExample() {
        let mov = MockMovie(overview: "something", poster_path: "path", vote_count: 0, vote_average: 6.0)
        let array: [MockMovie] = [mov]
        XCTAssertEqual(array.filterIncomplete().count, 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
