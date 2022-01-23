//
//  Epoch.swift
//  AstrophysicKit
//
//  Created by Aitor Salvador García on 26/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

/// Standard epoch values.
public enum Epoch {
    /// The standard 2000 epoch: January 1st, 2000, in the Julian calendar (1 year = 365.25 days).
    case J2000
    case custom(year: Int)

    init(date: Date) {
        let year = date.year
        switch year {
        case 2000:
            self = .J2000
        default:
            self = .custom(year: year)
        }
    }

    /// The value of the epoch, in Julian Days.
    var julianDay: Double {
        switch self {
        case .J2000:
            return 2451545.0
        case let .custom(year):
            let january1 = Date(day: 1, month: .january, year: year)
            return january1.midnightJulianDay - 1
        }
    }

    var year: Int {
        switch self {
        case .J2000:
            return 2000
        case let .custom(year):
            return year
        }
    }
}

extension Epoch: Equatable {}
