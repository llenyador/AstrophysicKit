//
//  Trigonometry.swift
//  AstrophysicKit
//
//  Created by Aitor Salvador García on 25/07/2020.
//  Copyright © 2020 Aitor Salvador García. All rights reserved.
//

import Foundation

public typealias Degrees = Double

public extension Double {
    var degrees: Degrees {
        self / .pi * 180
    }
}

public extension Degrees {
    var radians: Double {
        self / 180 * .pi
    }
}

public func sind(_ degrees: Degrees) -> Double {
    sin(degrees.radians)
}

public func cosd(_ degrees: Degrees) -> Double {
    cos(degrees.radians)
}
