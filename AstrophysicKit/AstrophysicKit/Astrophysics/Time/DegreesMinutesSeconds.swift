//
//  DegreesMinutesSeconds.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 17/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

public typealias DMS = DegreesMinutesSeconds

public struct DegreesMinutesSeconds: Equatable {
    let degrees: Int
    let minutes: Int
    let seconds: Double
    // TODO: Change to sign
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
        
        var degrees = Int(abs(decimalDegrees))
        var minutes = Int((abs(decimalDegrees) * .minutesInHour)
                            .truncatingRemainder(dividingBy: .minutesInHour))
        var seconds = round(abs(decimalDegrees) * .secondsInHour)
            .truncatingRemainder(dividingBy: .minutesInHour)
        if seconds >= 60 {
            seconds = 0
            minutes += 1
        }
        
        if minutes >= 60 {
            minutes = 0
            degrees += 1
        }
        
        if degrees >= 360 {
            degrees = 0
        }
        
        let sign = decimalDegrees.isNegative ? -1 : 1
//        let absDegrees = Double(abs(decimalDegrees))
//        self.degrees = sign * Int(absDegrees)
//        let decimalMinutes = absDegrees.truncatingRemainder(dividingBy: 1) * 60
//        self.minutes = Int(decimalMinutes)
//        let decimalSeconds = round(decimalMinutes.truncatingRemainder(dividingBy: 1) * 60)
//        self.seconds = decimalSeconds
//        self.sign = sign
        
        self.degrees = degrees
        self.minutes = minutes
        self.seconds = seconds
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

extension DegreesMinutesSeconds: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(sign * degrees)º \(minutes)' \(seconds)''"
    }
}
