//
//  UTtoLCTConverter.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 22/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

enum UTtoLCTConverter {
    static func convert(ut: UniversalTime,
                        at longitude: CLLocationDegrees) -> UTtoLCTConversionResult {
        let decimalTime = ut.hms.toDecimalHours()
        let adjustment = longitude.timeZoneAdjustment(rounded: true)
        var localTimeDecimal = decimalTime + adjustment
        var isPreviousDay = false
        var isNextDay = false
        if localTimeDecimal.isLess(than: 0) {
            localTimeDecimal += .hoursInDay
            isPreviousDay = true
        } else if localTimeDecimal > 24 {
            localTimeDecimal -= .hoursInDay
            isNextDay = true
        }
        
        if ut.isDaylightSavingTime {
            localTimeDecimal += 1
        }
        
        let hms = HoursMinutesSeconds(decimalHours: localTimeDecimal)
        let lct = LocalCivilTime(hoursMinutesSeconds: hms,
                                 isDaylightSavingTime: ut.isDaylightSavingTime)
        return UTtoLCTConversionResult(lct: lct,
                                       isNextDay: isNextDay,
                                       isPreviousDay: isPreviousDay)
    }
}
