//
//  GSTtoLSTConverter.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 22/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

enum GSTtoLSTConverter {
    static func convert(gst: GreenwichSiderealTime,
                        for longitude: CLLocationDegrees) -> GSTtoLSTConversionResult {
        let gstDecimal = gst.hms.toDecimalHours()
        let adjustment = longitude.timeZoneAdjustment(rounded: false)
        var lstDecimal = gstDecimal + adjustment
        if lstDecimal.isNegative {
            lstDecimal += .hoursInDay
        } else if lstDecimal.isGreater(than: .hoursInDay) {
            lstDecimal -= .hoursInDay
        }
        
        let lstHMS = HoursMinutesSeconds(decimalHours: lstDecimal)
        let lst = LocalSiderealTime(hms: lstHMS)
        return GSTtoLSTConversionResult(lst: lst)
    }
}
