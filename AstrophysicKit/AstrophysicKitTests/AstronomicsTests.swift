//
//  AstronomicsTests.swift
//  AstronomicsTests
//
//  Created by Aitor Salvador García on 16/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import XCTest
@testable import AstrophysicKit



class AstronomicsTests: XCTestCase {

    func testJulianDayConvsersion() {
        let hms = HoursMinutesSeconds(hours: 0, minutes: 0, seconds: 0)
        let date = Date(day: 1, month: .january, year: 2010, hms: hms)
        XCTAssertEqual(date.toJulianDate(), Double(2455197.50))
    }

}
