//
//  DegreesMinutesSeconds.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 17/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

struct DegreesMinutesSeconds: Equatable {
    let degrees: Int
    let minutes: Int
    let seconds: Double
    let sign: Int // -1 or 1
    
    init(sign: Int,
         degrees: Int,
         minutes: Int,
         seconds: Double) {
        
        guard sign == -1 || sign == 1 else {
            fatalError("Invalid sign \(sign)")
        }
        
        guard -360 <= degrees && degrees <= 360,
            minutes <= 60 && minutes >= 0,
            seconds <= 60 && seconds >= 0 else {
                fatalError("Invalid DegreesMinutesSeconds: \(degrees) H \(minutes) min \(seconds) sec")
        }
        self.degrees = degrees
        self.minutes = minutes
        self.seconds = seconds
        self.sign = sign
    }
    
    init(decimalDegrees: Double) {
        let sign = decimalDegrees < 0 ? -1 : 1
        let absDegrees = Double(abs(decimalDegrees))
        self.degrees = sign * Int(absDegrees)
        let decimalMinutes = absDegrees.truncatingRemainder(dividingBy: 1) * 60
        self.minutes = Int(decimalMinutes)
        let decimalSeconds = decimalMinutes.truncatingRemainder(dividingBy: 1) * 60
        self.seconds = Double(Int(decimalSeconds))
        self.sign = sign
    }
    
    func toDecimalDegrees() -> Double {
        let absDegrees = Double(abs(degrees))
        let decimalMinutes = seconds / 60
        let totalMinutes = Double(minutes) + decimalMinutes
        let totalDecimalMinutes = totalMinutes / 60
        return Double(sign) * (absDegrees + totalDecimalMinutes)
    }
}
