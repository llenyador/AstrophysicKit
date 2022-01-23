//
//  JulianCenturies.swift
//  AstrophysicKit
//
//  Created by Aitor Salvador García on 26/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

/**
 Represents the julian centuries since standard epoch J2000.
 */
public struct JulianCenturies {
    let epoch: Epoch
    
    /**
     Returns the julian centuries since standard epoch J2000 to the specified year.
    */
    lazy var numberOfCenturies: Double = {
        (epoch.julianDay - Epoch.J2000.julianDay) / 36525
    }()
    
    public init(epoch: Epoch) {
        self.epoch = epoch
    }
}

// MARK: - CustomDebugStringConvertible
extension JulianCenturies: CustomDebugStringConvertible {
    public var debugDescription: String {
        "J\(epoch)"
    }
}
