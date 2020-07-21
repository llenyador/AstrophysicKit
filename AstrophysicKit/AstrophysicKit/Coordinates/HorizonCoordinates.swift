//
//  HorizonCoordinates.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 16/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

struct HorizonCoordinates {
    let azimut: Double
    let altitude: Double
    
    func toEquatorialCoordinates(observerLatitude: Double) -> EquatorialCoordinates {
        let sinDeclination = ( sin(altitude) * sin(observerLatitude) )
            + ( cos(altitude) * cos(observerLatitude) * cos(azimut) )
        
        let declination = asin(sinDeclination)
        
        let cosOfHourAngle = ( sin(altitude) - sin(observerLatitude) * sin(declination) ) /
            ( cos(observerLatitude) * cos(declination) )
        
        let hourAngle = acos(cosOfHourAngle)
        let sinOfAzimut = sin(azimut)
        var H: HourAngle = hourAngle
        if sinOfAzimut > 0 {
            H = 360 - hourAngle
        }
        
        H = H / 15 // converts H to hours to give the hour angle
        
        return EquatorialCoordinates(declination: declination,
                                     rightAscension: 2,
                                     hourAngle: hourAngle)
    }
}
