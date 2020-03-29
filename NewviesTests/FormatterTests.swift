//
//  NVDateFormatter.swift
//  NewviesTests
//
//  Created by Jay Jac on 3/18/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import XCTest
@testable import Newvies

class FormatterTests: XCTestCase {



    func testFormatting() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: "2020-03-20")
        XCTAssertNotNil(date)
    }
    
    func test_NumberFormats() {
        let number = 1200
        print(LabelTextFormatter.formatVoteCount(number))
    }



}
