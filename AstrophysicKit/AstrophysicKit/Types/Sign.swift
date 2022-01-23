//
//  Sign.swift
//  AstrophysicKit
//
//  Created by Aitor Salvador García on 15/5/21.
//  Copyright © 2021 Aitor Salvador García. All rights reserved.
//

import Foundation

enum Sign {
    case positive
    case negative
    
    init<T: Numeric & AdditiveArithmetic & Comparable>(_ value: T) {
        if value >= T.zero {
            self = .positive
        } else {
            self = .negative
        }
    }
}
