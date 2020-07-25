//
//  TimeConversionResults.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 18/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

struct LCTtoUTConversionResult: Equatable {
    let ut: UniversalTime
    let isNextDay: Bool
    let isPreviousDay: Bool
}

struct UTtoLCTConversionResult: Equatable {
    let lct: LocalCivilTime
    let isNextDay: Bool
    let isPreviousDay: Bool
}

struct UTtoGSTConversionResult: Equatable {
    let gst: GreenwichSiderealTime
}

struct GSTtoUTConversionResult: Equatable {
    let ut: UniversalTime
}

struct GSTtoLSTConversionResult: Equatable {
    let lst: LocalSiderealTime
}

struct LSTtoGSTConversionResult: Equatable {
    let gst: GreenwichSiderealTime
}
