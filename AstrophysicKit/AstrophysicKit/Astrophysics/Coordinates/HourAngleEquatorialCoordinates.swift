//
//  HourAngleEquatorialCoordinates.swift
//  AstrophysicKit
//
//  Created by Aitor Salvador García on 23/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

struct HourAngleEquatorialCoordinates: Equatable {
    let declination: Double
    let hourAngle: HourAngle
    
    init(declination: Double,
         hourAngle: Double) {
        self.declination = declination
        self.hourAngle = hourAngle
    }
    
    init(declination: DegreesMinutesSeconds,
         hourAngle: HoursMinutesSeconds) {
        self.declination = declination.toDecimalDegrees()
        self.hourAngle = hourAngle.toDecimalHours()
    }
    
    func toEquatorialCoordinates(at lst: LocalSiderealTime) -> EquatorialCoordinates {
        EquatorialCoordinates(declination: declination,
                              rightAscension: rightAscension(for: lst))
    }
    
    func rightAscension(for lst: LocalSiderealTime) -> Double {
        lst.hms.toDecimalHours() - hourAngle
    }
    
    func toHorizonCoordinates(at latitude: CLLocationDegrees) -> HorizonCoordinates {
        let hourAngleDegrees = hourAngle * .rotationDegreesByAnHour
        let T0 = sind(declination) * sind(latitude) +
        cosd(declination) * cosd(latitude) * cosd(hourAngleDegrees)
        let altitude: Degrees = asin(T0).degrees
        
        let T1 = sind(declination) - sind(latitude) * sind(altitude)
        let T2 = T1 / ( cosd(latitude) * cosd(altitude) )
        
        var azimut: Degrees = acos(T2).degrees
        
        if sind(hourAngleDegrees).isPositive {
            azimut = 360 - azimut
        }
        
        return HorizonCoordinates(azimut: azimut,
                                  altitude: altitude)
    }
}


