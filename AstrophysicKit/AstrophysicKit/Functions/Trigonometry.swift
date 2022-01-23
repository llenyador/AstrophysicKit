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

public func tand(_ degrees: Degrees) -> Double {
    tan(degrees.radians)
}


/**
 Applies a correction to the arctangent by sign of numerator and denominator.
 
 
    When the arctangent is required and the resulting angle is supposed to be in the range 0º to 360º, the argument to the arctangent function will be given in the form y/x. The correct angle obtained from the arctangent depends on the numeric sign of y and x. There are 4 cases to consider as summarized in table 1.

    - Note
    Remember, however, that an adjustment is needed only if the resulting angle is to be in the range [0º, 360º] instead of [−90º, +90º].

    - Example:
    Suppose y = 5, x = −2, and the angle θ is to be in the range 0º to 360º. Now θ = tan−1(5/−2) = −68.1986º. Table 4.1 indicates that 180º must be added to θ to place the angle in the correct quadrant. Therefore, the correct answer is θ = −68.1986º + 180º = 111.8014º.

     Table 1:
     | y | x | Adjustment |
     |---|---|------------|
     | + | + | 0◦         |
     | + | − | 180◦       |
     | − | + | 360◦       |
     | − | − | 180◦       |
 */
public func atanCorrected(numerator: Double,
                          denominator: Double) -> Degrees {
    let y = numerator
    let x = denominator
    let ySign = Sign(y)
    let xSign = Sign(x)
    
    var adjustment: Double = 0
    switch (ySign, xSign) {
    case (.positive, .positive):
        adjustment = 0
    case (.positive, .negative):
        adjustment = 180
    case (.negative, .positive):
        adjustment = 360
    case (.negative, .negative):
        adjustment = 180
    }
    return atan(numerator / denominator).degrees + adjustment
}

func wrapTo180(_ degrees: Degrees) -> Degrees {
    var wrapped = fmod(degrees, 360)
    if wrapped < 0.0 {
        wrapped += 360
    }
    if wrapped > 180 {
        wrapped -= 360
    }
    return wrapped
}
