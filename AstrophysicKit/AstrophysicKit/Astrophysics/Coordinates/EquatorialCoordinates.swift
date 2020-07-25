//
//  EquatorialCoordinates.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 16/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

typealias HourAngle = Double

struct EquatorialCoordinates: Equatable {
    let declination: Double
    let rightAscension: Double
    
    init(declination: Double,
         rightAscension: Double) {
        self.declination = declination
        self.rightAscension = rightAscension
    }
    
    init(declination: DegreesMinutesSeconds,
         rightAscension: DegreesMinutesSeconds) {
        self.declination = declination.toDecimalDegrees()
        self.rightAscension = rightAscension.toDecimalDegrees()
    }
    
    func toHourAngleEquatorialCoordinates(at lst: LocalSiderealTime) -> HourAngleEquatorialCoordinates {
        HourAngleEquatorialCoordinates(declination: declination,
                                       hourAngle: hourAngle(for: lst))
    }
    
    func hourAngle(for lst: LocalSiderealTime) -> HourAngle {
        rightAscension + lst.hms.toDecimalHours()
    }
    
    func toHorizonCoordinates() -> HorizonCoordinates {
        HorizonCoordinates(azimut: 0, altitude: 0)
    }
}

