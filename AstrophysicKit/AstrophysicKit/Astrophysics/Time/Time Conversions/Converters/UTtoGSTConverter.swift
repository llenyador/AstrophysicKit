//
//  UTtoGSTConverter.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 22/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

enum UTtoGSTConverter {
    static func convert(ut: UniversalTime,
                        for date: Date) -> UTtoGSTConversionResult {
        let elapsedDays = date.elapsedDays
        let T = ( date.startingJulianYearDate - 2415020.0 ) / 36525.0
        let R_1 = (2400.051262 * T)
        let R_2 = ( 0.00002581 * (T * T) )
        let R = 6.6460656 + R_1 + R_2
        let B = 24 - R + 24 * (Double(date.year) - 1900)
        let T0 = ( 0.0657098 * elapsedDays ) - B
        
        let decimalUT = ut.hms.toDecimalHours()
        var decimalGST = T0 + 1.002738 * decimalUT
        if decimalGST < 0 {
            decimalGST += 24
        } else if decimalGST > 24 {
            decimalGST -= 24
        }
        let hms = HoursMinutesSeconds(decimalHours: decimalGST)
        let gst = GreenwichSiderealTime(hms: hms)
        return UTtoGSTConversionResult(gst: gst)
    }
}
