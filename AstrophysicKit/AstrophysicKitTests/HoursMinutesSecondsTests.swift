//
//  HoursMinutesSecondsTests.swift
//  AstronomicsTests
//
//  Created by Aitor Salvador García on 17/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

@testable import AstrophysicKit
import XCTest

class HoursMinutesSecondsTests: XCTestCase {

    func testHoursMinutesSecondsConversions() {
        let t = HoursMinutesSeconds(hours: 4,
                          minutes: 30,
                          seconds: 0)
        XCTAssertEqual(t.toDecimalHours(), 4.5)
        
        let t2 = HoursMinutesSeconds(decimalHours: 4.5)
        XCTAssertEqual(t2, t)
        
        let t3 = HoursMinutesSeconds(decimalHours: 21.031560)
        let expectedT3 = HoursMinutesSeconds(hours: 21, minutes: 1, seconds: 54)
        XCTAssertEqual(t3, expectedT3)
        
        let t4 = HoursMinutesSeconds(hours: 0, minutes: 18, seconds: 0)
        XCTAssertEqual(t4.toDecimalHours(), 0.3)
    }

}
