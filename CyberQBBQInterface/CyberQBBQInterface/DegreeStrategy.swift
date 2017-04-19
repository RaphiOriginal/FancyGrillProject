//
//  DegreeStrategy.swift
//  CyberQBBQInterface
//
//  Created by Raphael Brunner on 19.04.17.
//  Copyright © 2017 Raphael Brunner. All rights reserved.
//

import Foundation

protocol DegreeStrategy {
    func getValue(rawValue:Double) -> Double
}

class CelsiusStrategy: DegreeStrategy {
    func getValue(rawValue: Double) -> Double {
        // TODO: how to round this better...
        return ((rawValue/10 - 32) * 5/9).rounded()
    }
}

class FahrenheitStrategy: DegreeStrategy {
    func getValue(rawValue: Double) -> Double {
        return rawValue/10
    }
}
