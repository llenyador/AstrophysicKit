//
//  UniversalTime.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 18/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

struct UniversalTime: Equatable {
    let hms: HoursMinutesSeconds
    let isDaylightSavingTime: Bool
    
    init(hoursMinutesSeconds: HoursMinutesSeconds,
         isDaylightSavingTime: Bool) {
        self.hms = hoursMinutesSeconds
        self.isDaylightSavingTime = isDaylightSavingTime
    }
    
    func toLCT(from longitude: CLLocationDegrees) -> UTtoLCTConversionResult {
        UTtoLCTConverter.convert(ut: self, at: longitude)
    }
    
    func toGST(at date: Date) -> UTtoGSTConversionResult {
        UTtoGSTConverter.convert(ut: self, for: date)
    }
}
