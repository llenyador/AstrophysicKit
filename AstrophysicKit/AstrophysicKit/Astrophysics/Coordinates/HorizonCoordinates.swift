//
//  HorizonCoordinates.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 16/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

/**
 Locates object through horizon coordinates for an observer.
 */
struct HorizonCoordinates: Equatable {
    let azimut: Degrees
    let altitude: Degrees
    
    /**
     Flag that indicates if object with these horizon coordinates is visible in its horizon.
     */
    var isBelowHorizon: Bool {
        altitude.isNegative
    }
    
    func toEquatorialCoordinates(observerLatitude: Degrees,
                                 lst: LocalSiderealTime) -> EquatorialCoordinates {
        let sinDeclination = ( sind(altitude) * sind(observerLatitude) )
            + ( cosd(altitude) * cosd(observerLatitude) * cosd(azimut) )
        
        let declination = asin(sinDeclination).degrees
        
        let cosOfHourAngle = ( sind(altitude) - sind(observerLatitude) * sind(declination) ) /
            ( cosd(observerLatitude) * cosd(declination) )
        
        let hourAngle = acos(cosOfHourAngle).degrees
        let sinOfAzimut = sind(azimut)
        var H: HourAngle = hourAngle
        if sinOfAzimut > 0 {
            H = 360 - hourAngle
        }
        
        H = H / 15 // converts H to hours to give the hour angle
        let rightAscension = lst.hms.toDecimalHours() - H
        return EquatorialCoordinates(declination: declination,
                                     rightAscension: rightAscension)
    }
}


