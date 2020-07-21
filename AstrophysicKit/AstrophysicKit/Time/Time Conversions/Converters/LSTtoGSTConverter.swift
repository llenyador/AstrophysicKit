//
//  LSTtoGSTConverter.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 22/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

enum LSTtoGSTConverter {
    static func convert(lst: LocalSiderealTime,
                        for longitude: CLLocationDegrees) -> LSTtoGSTConversionResult {
        let lstDecimal = lst.hms.toDecimalHours()
        let adjustment = longitude.timeZoneAdjustment(rounded: false)
        var gstDecimal = lstDecimal - adjustment
        if gstDecimal.isNegative {
            gstDecimal += .hoursInDay
        } else if lstDecimal.isGreater(than: .hoursInDay) {
            gstDecimal -= .hoursInDay
        }
        
        let gstHMS = HoursMinutesSeconds(decimalHours: gstDecimal)
        let gst = GreenwichSiderealTime(hms: gstHMS)
        return LSTtoGSTConversionResult(gst: gst)
    }
}
