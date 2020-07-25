//
//  HoursMinutesSeconds.swift
//  Astronomics
//
//  Created by Aitor Salvador García on 17/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

public typealias HMS = HoursMinutesSeconds

public struct HoursMinutesSeconds: Equatable {
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    init(hours: Int,
         minutes: Int,
         seconds: Int) {
        
        guard hours <= 24 && hours >= 0,
            minutes <= 60 && minutes >= 0,
            seconds <= 60 && seconds >= 0 else {
                fatalError("Invalid HoursMinutesSeconds: \(hours) H \(minutes) min \(seconds) sec")
        }
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    init(decimalHours: Double) {
        var hours = Int(decimalHours)
        var minutes = Int((decimalHours * 60).truncatingRemainder(dividingBy: 60))
        var seconds = Int(round(decimalHours * 3600).truncatingRemainder(dividingBy: 60))
        if seconds >= 60 {
            seconds = 0
            minutes += 1
        }
        
        if minutes >= 60 {
            minutes = 0
            hours += 1
        }
        
        if hours >= 24 {
            hours = 0
        }
        
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    
    func toDecimalHours() -> Double {
        let decimalHours = Double(hours)
        let decimalMinutes = Double(minutes) / 60
        let decimalSeconds = Double(seconds) / (60 * 60)
        return decimalHours + decimalMinutes + decimalSeconds
    }
}

extension HoursMinutesSeconds: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(hours)h \(minutes)m \(seconds)s"
    }
}
