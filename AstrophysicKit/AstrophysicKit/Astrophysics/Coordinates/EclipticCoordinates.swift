//
//  EclipticCoordinates.swift
//  AstrophysicKit
//
//  Created by Aitor Salvador García on 25/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

struct EclipticCoordinates: Equatable {
    let eclipticLatitude: Degrees
    let eclipticLongitude: Degrees
    let epsilon: Degrees
    let epoch: Epoch
    
    var beta: Degrees {
        eclipticLatitude
    }
    
    var lambda: Degrees {
        eclipticLongitude
    }
    
    init(eclipticLatitude: Degrees,
         eclipticLongitude: Degrees,
         epoch: Epoch) {
        self.eclipticLatitude = eclipticLatitude
        self.eclipticLongitude = eclipticLongitude
        self.epoch = epoch
        self.epsilon = Self.obliquityOfTheEclipticPlane(epoch: epoch)
    }
    
    init(beta: Degrees,
         lambda: Degrees,
         epoch: Epoch) {
        self.init(eclipticLatitude: beta,
                  eclipticLongitude: lambda,
                  epoch: epoch)
    }
    
    init(eclipticLatitude: DegreesMinutesSeconds,
         eclipticLongitude: DegreesMinutesSeconds,
         epoch: Epoch) {
        self.init(eclipticLatitude: eclipticLatitude.toDecimalDegrees(),
                  eclipticLongitude: eclipticLongitude.toDecimalDegrees(),
                  epoch: epoch)
    }
    
    /**
     Returns the obliquity of the ecliptic plane, which is the angle between the ecliptic plane and the plane containing the celestial equator.
     */
    static func obliquityOfTheEclipticPlane(epoch: Epoch) -> Degrees {
        guard epoch != .J2000 else {
            return 23.439292
        }
        var julianCenturiesSince2000 = JulianCenturies(epoch: epoch)
        let T = julianCenturiesSince2000.numberOfCenturies
        
        
        let numerator = T * (46.815 + T * (0.0006 - 0.00181 * T))
        let eclipticAngleCorrection = numerator / 3600
        let decimalObliquity = Constants.standardEpochObliquityJ2000 - eclipticAngleCorrection
        return decimalObliquity
    }
}

// MARK: - Coordinates conversion
extension EclipticCoordinates {
    /**
     Converts from Ecliptic to Equatorial coordinates.
     
    - Uses following formulas:
     
        sin δ = sin β cos ε + cos β sin ε sin λ
     
        tan α = (sin λ cos ε − tan β sin ε) / cos λ
     */
    func toEquatorialCoordinates() -> EquatorialCoordinates {
        let sinOfDeclination = ( sind(beta) * cosd(epsilon) ) +
            ( cosd(beta) * sind(epsilon) * sind(lambda) )
        let declination = asin(sinOfDeclination).degrees
        
        let tanAscensionNumerator = ( sind(lambda) * cosd(epsilon) ) -
        ( tand(beta) * sind(epsilon))
        let tanAscensionDenominator = cosd(lambda)
        let ascension = atanCorrected(numerator: tanAscensionNumerator,
                                      denominator: tanAscensionDenominator)
        let ascensionHours = ascension / 15
        
        return EquatorialCoordinates(declination: declination,
                                     rightAscension: ascensionHours)
    }
}

private extension EclipticCoordinates {
    enum Constants {
        static let standardEpochObliquityJ2000: Degrees = 23.439292
    }
}

extension EclipticCoordinates: CustomDebugStringConvertible {
    var debugDescription: String {
        """

        {
            β = (\(DMS(decimalDegrees: beta))),
            λ = (\(DMS(decimalDegrees: lambda))),
            ε = (\(DMS(decimalDegrees: epsilon)))
        }

        """
    }
}
