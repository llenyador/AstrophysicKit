//
//  JulianCenturiesTests.swift
//  AstrophysicKitTests
//
//  Created by Aitor Salvador García on 25/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

@testable import AstrophysicKit
import XCTest

class JulianCenturiesTests: XCTestCase {

    func testNumberOfJulianCeturies() {
        var jc = JulianCenturies(epoch: .custom(year: 2010))
        XCTAssertEqual(jc.numberOfCenturies, 0.09997262149212868)
    }

}
