//
//  CoordinatesTests.swift
//  AstrophysicKitTests
//
//  Created by Aitor Salvador García on 22/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

@testable import AstrophysicKit
import XCTest

class CoordinatesTests: XCTestCase {
    func testHorizonToEquatorial() {
        let horizon = HorizonCoordinates(azimut: 115,
                                         altitude: 40)
//        let ecuatorial = horizon.toEquatorialCoordinates(observerLatitude: 38)
    }
    
    func testEquatorialToHorizon() {
        let declination = DegreesMinutesSeconds(sign: -1, degrees: 0, minutes: 30, seconds: 30)
        let hourAngle = HoursMinutesSeconds(hours: 16, minutes: 29, seconds: 45)
        let equatorialCoords = HourAngleEquatorialCoordinates(declination: declination.toDecimalDegrees(),
                                                     hourAngle: hourAngle.toDecimalHours())
        equatorialCoords.toHorizonCoordinates(at: 25)
    }
}
