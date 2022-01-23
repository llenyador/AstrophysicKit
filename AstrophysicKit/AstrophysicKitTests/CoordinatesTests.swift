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
    
    
    func testEcplipticToEquatorial() {
        let lat = DegreesMinutesSeconds(sign: 1,
                                        degrees: 1,
                                        minutes: 12,
                                        seconds: 0)
        let long = DegreesMinutesSeconds(sign: 1,
                                         degrees: 184,
                                         minutes: 36,
                                         seconds: 0)
        let coords = EclipticCoordinates(eclipticLatitude: lat,
                                         eclipticLongitude: long,
                                         epoch: .J2000)
        let result = coords.toEquatorialCoordinates()
        let expectedResult = EquatorialCoordinates(declination: -0.72653054058506761,
                                                   rightAscension: 12.313193170484958)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testEquatorialToEcpliptic() {
        
        let rightAscension = HMS(hours: 12,
                                 minutes: 18,
                                 seconds: 47.5).toDecimalHours()
        
        let declination = DMS(sign: -1,
                              degrees: 0,
                              minutes: 43,
                              seconds: 35.5).toDecimalDegrees()
        let equatorialCoordinates = EquatorialCoordinates(declination: declination,
                                                          rightAscension: rightAscension)
        let result = equatorialCoordinates.toEclipticCoordinates(at: .J2000)
        
        let b = DegreesMinutesSeconds(sign: 1, degrees: 1, minutes: 12, seconds: 0)
        let l = DegreesMinutesSeconds(sign: 1, degrees: 184, minutes: 36, seconds: 0)
        let expectedResult = EclipticCoordinates(eclipticLatitude: b,
                                                 eclipticLongitude: l,
                                                 epoch: .J2000)
        print(result)
        print(expectedResult)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testEquatorialToEcpliptic2() {
        let rightAscension = HMS(hours: 11,
                                 minutes: 10,
                                 seconds: 13).toDecimalHours()
        
        let declination = DMS(sign: -1,
                              degrees: 30,
                              minutes: 5,
                              seconds: 40).toDecimalDegrees()
        let equatorialCoordinates = EquatorialCoordinates(declination: declination,
                                                          rightAscension: rightAscension)
        let result = equatorialCoordinates.toEclipticCoordinates(at: .J2000)

        let b = DegreesMinutesSeconds(sign: 1, degrees: 22, minutes: 41, seconds: 54)
        let l = DegreesMinutesSeconds(sign: 1, degrees: 156, minutes: 19, seconds: 9)
        let expectedResult = EclipticCoordinates(eclipticLatitude: b,
                                                 eclipticLongitude: l,
                                                 epoch: .J2000)
        print(result)
        print(expectedResult)
        XCTAssertEqual(result, expectedResult)
    }
    
    func av() {
        let asinx = 0.020943
        let T = sind(asinx)
        
        
    }
}
