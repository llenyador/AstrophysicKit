//
//  GSTtoUTConverter.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 22/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

enum GSTtoUTConverter {
    static func convert(gst: GreenwichSiderealTime,
                        for date: Date) -> GSTtoUTConversionResult {
        let startingYearJulianDate = date.startingJulianYearDate
        let elapsedDays = date.elapsedDays
        let T = (startingYearJulianDate - 2415020) / 36525
        let R_1 = (2400.051262 * T)
        let R_2 = ( 0.00002581 * (T * T) )
        let R = 6.6460656 + R_1 + R_2
        let B = 24 - R + 24 * (Double(date.year) - 1900)
        var T0 = ( 0.0657098 * elapsedDays ) - B
        if T0.isNegative {
            T0 += 24
        } else if T0.isGreater(than: 24) {
            T0 -= 24
        }
        
        let decimalGST = gst.hms.toDecimalHours()
        
        var A = decimalGST - T0
        if A.isNegative {
            A += .hoursInDay
        }
        let decimalUT = 0.997270 * A
        let utHMS = HoursMinutesSeconds(decimalHours: decimalUT)
        
        let ut = UniversalTime(hoursMinutesSeconds: utHMS,
                               isDaylightSavingTime: false)
        return GSTtoUTConversionResult(ut: ut)
    }
}
