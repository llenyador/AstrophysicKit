//
//  GreenwichSiderealTime.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 21/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import CoreLocation

struct GreenwichSiderealTime: Equatable {
    let hms: HoursMinutesSeconds
    
    init(hms: HoursMinutesSeconds) {
        self.hms = hms
    }
    
    func toUT(for date: Date) -> GSTtoUTConversionResult {
        GSTtoUTConverter.convert(gst: self, for: date)
    }
    
    func toLST(for longitude: CLLocationDegrees) -> GSTtoLSTConversionResult {
        GSTtoLSTConverter.convert(gst: self, for: longitude)
    }
}
