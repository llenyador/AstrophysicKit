//
//  LocalCivilTime.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 18/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

struct LocalCivilTime: Equatable {
    let hms: HoursMinutesSeconds
    let isDaylightSavingTime: Bool
    
    init(hoursMinutesSeconds: HoursMinutesSeconds,
         isDaylightSavingTime: Bool) {
        self.hms = hoursMinutesSeconds
        self.isDaylightSavingTime = isDaylightSavingTime
    }
    
    func toUT(from longitude: CLLocationDegrees) -> LCTtoUTConversionResult {
        LCTtoUTConverter.convert(lct: self, for: longitude)
    }
}
