//
//  LCTtoUTConverter.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 22/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

enum LCTtoUTConverter {
    static func convert(lct: LocalCivilTime,
                        for longitude: CLLocationDegrees) -> LCTtoUTConversionResult {
        var decimalTime = lct.hms.toDecimalHours()
        if lct.isDaylightSavingTime {
            decimalTime -= 1
        }
        let adjustment = longitude.timeZoneAdjustment(rounded: true)
        var universalTimeDecimal = decimalTime - adjustment
        let isNextDay = universalTimeDecimal.isLess(than: 0)
        if isNextDay {
            universalTimeDecimal -= .hoursInDay
        }
        let hms = HoursMinutesSeconds(decimalHours: universalTimeDecimal)
        let ut = UniversalTime(hoursMinutesSeconds: hms,
                               isDaylightSavingTime: lct.isDaylightSavingTime)
        return LCTtoUTConversionResult(ut: ut,
                                       isNextDay: isNextDay,
                                       isPreviousDay: false) // ?? could not be previous day?????
    }
}
