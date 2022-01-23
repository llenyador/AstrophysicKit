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
    let declination: Degrees
    let rightAscension: Degrees
    
    var delta: Degrees {
        declination
    }
    
    var alpha: Degrees {
        rightAscension
    }
    
    init(declination: Degrees,
         rightAscension: Degrees) {
        self.declination = declination
        self.rightAscension = rightAscension
    }
    
    init(declination: DegreesMinutesSeconds,
         rightAscension: DegreesMinutesSeconds) {
        self.declination = declination.toDecimalDegrees()
        self.rightAscension = rightAscension.toDecimalDegrees()
    }
    
    func hourAngle(for lst: LocalSiderealTime) -> HourAngle {
        rightAscension + lst.hms.toDecimalHours()
    }
}

// MARK: - Coordinates conversions
extension EquatorialCoordinates {
    func toHourAngleEquatorialCoordinates(at lst: LocalSiderealTime) -> HourAngleEquatorialCoordinates {
        .init(declination: declination,
              hourAngle: hourAngle(for: lst))
    }
    
    func toHorizonCoordinates(observerLatitude: Degrees,
                              at lst: LocalSiderealTime) -> HorizonCoordinates {
        toHourAngleEquatorialCoordinates(at: lst)
            .toHorizonCoordinates(at: observerLatitude)
    }
    
    /**
     Converts from Equatorial to Ecliptic coordinates.
     
    - Uses following formulas:
     
             sin β = sin δ cos ε + cos δ sin ε sin α
             
             tan λ = (sin α cos ε − tan δ sin ε) / cos α
     */
    func toEclipticCoordinates(at epoch: Epoch) -> EclipticCoordinates {
        let epsilon = EclipticCoordinates.obliquityOfTheEclipticPlane(epoch: epoch)
        let alphaDeg = rightAscension * 15
        
        let sinOfBeta = ( sind(delta) * cosd(epsilon) ) - ( cosd(delta) * sind(epsilon) * sind(alphaDeg) )
        let beta = asin(sinOfBeta).degrees // I needed to perform - sign to obtain results, i don't know why
        
        print("ε = \(epsilon)")
        print("α = \(alpha)")
        print("α_deg = \(alphaDeg)")
        print("δ = \(delta)")
        print("sin(β) = \(sinOfBeta)")
        print("β = \(beta)")
        
        let tanLambdaNumerator = ( sind(alphaDeg) * cosd(epsilon) ) +
        ( tand(delta) * sind(epsilon))
        let tanLambdaDenominator = cosd(alphaDeg)
        let lambda = atan2(tanLambdaNumerator, tanLambdaDenominator)
        
        return EclipticCoordinates(beta: beta,
                                   lambda: lambda,
                                   epoch: epoch)
    }
}
