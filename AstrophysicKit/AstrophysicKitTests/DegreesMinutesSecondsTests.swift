//
//  DegreesMinutesSecondsTests.swift
//  AstronomicsTests
//
//  Created by Aitor Salvador García on 17/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

@testable import AstrophysicKit
import XCTest

class DegreesMinutesSecondsTests: XCTestCase {

    func testConversions() {
        let t = DegreesMinutesSeconds(sign: -1,
                                      degrees: 0,
                                      minutes: 35,
                                      seconds: 9.599999999999795)
        XCTAssertEqual(t.toDecimalDegrees(), -0.586)
        
        let t2 = DegreesMinutesSeconds(decimalDegrees: -0.586)
        XCTAssertEqual(t2, t)
    }

}
