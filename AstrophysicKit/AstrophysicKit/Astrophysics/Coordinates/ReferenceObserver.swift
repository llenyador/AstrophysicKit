//
//  ReferenceObserver.swift
//  AstrophysicKit
//
//  Created by Aitor Salvador García on 25/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

struct ReferenceObserver {
    let date: Date
    let longitude: Degrees
    let latitude: Degrees
    
    let timeZone: TimeZone?
    
    var localSiderealTime: LocalSiderealTime {
        let isDaylightSavingTime = timeZone?.isDaylightSavingTime(for: date) ?? false
        return LocalSiderealTime(hms: date.hms())
    }
}
