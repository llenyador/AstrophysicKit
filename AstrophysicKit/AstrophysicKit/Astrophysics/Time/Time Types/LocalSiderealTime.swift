//
//  LocalSiderealTime.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 22/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

struct LocalSiderealTime: Equatable {
    let hms: HoursMinutesSeconds
    
    init(hms: HoursMinutesSeconds) {
        self.hms = hms
    }
    
    func toGST(for longitude: CLLocationDegrees) -> LSTtoGSTConversionResult {
        LSTtoGSTConverter.convert(lst: self, for: longitude)
    }
}
