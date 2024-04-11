//
//  Convertable.swift
//  Sweet
//
//  Created by jowsing on 2024/4/11.
//

import Foundation

protocol Convertable: Codable {
    func convert<T>() -> T where T: Defaultable
}

extension String: Convertable {
    
    func convert<T: Defaultable>() -> T {
        var result: T?
        if T.self == Self.self {
            result = self as? T
        }
        else if let boolValue = Bool(self) {
            result = boolValue.convert()
        }
        else if let intValue = Int(self) {
            result = intValue.convert()
        }
        else if let uintValue = UInt(self) {
            result = uintValue.convert()
        }
        else if let doubleValue = Double(self) {
            result = doubleValue.convert()
        }
        return result ?? T.default
    }
}

extension Bool: Convertable {
    
    var int: Int {
        return self ? 1 : 0
    }
    
    func convert<T>() -> T where T : Defaultable {
        var result: T?
        if T.self == Self.self {
            result = self as? T
        }
        else if T.self == String.self {
            result = String(self) as? T
        }
        else if T.self == Int.self {
            result = int as? T
        }
        else if T.self == Double.self {
            result = Double(int) as? T
        }
        else if T.self == Float.self {
            result = Float(int) as? T
        }
        return result ?? T.default
    }
}

extension Double: Convertable {
    
    func convert<T>() -> T where T : Defaultable {
        var result: T?
        if T.self == Self.self {
            result = self as? T
        }
        else if T.self == String.self {
            result = String(self) as? T
        }
        else if T.self == Int.self {
            result = Int(self) as? T
        }
        else if T.self == Bool.self {
            result = (self > 0) as? T
        }
        else if T.self == Float.self {
            result = Float(self) as? T
        }
        return result ?? T.default
    }
}

extension Int: Convertable {
    
    var bool: Bool {
        return self > 0
    }
    
    func convert<T>() -> T where T : Defaultable {
        var result: T?
        if T.self == Self.self {
            result = self as? T
        }
        else if T.self == String.self {
            result = String(self) as? T
        }
        else if T.self == Bool.self {
            result = bool as? T
        }
        else if T.self == Double.self {
            result = Double(self) as? T
        }
        else if T.self == Float.self {
            result = Float(self) as? T
        }
        else if let intType = T.self as? any FixedWidthInteger.Type {
            result = intType.init(self) as? T
        }
        return result ?? T.default
    }
}

extension UInt: Convertable {
    
    func convert<T>() -> T where T : Defaultable {
        var result: T?
        if T.self == Self.self {
            result = self as? T
        }
        else if T.self == String.self {
            result = String(self) as? T
        }
        else if T.self == Bool.self {
            result = (self > 0) as? T
        }
        else if T.self == Double.self {
            result = Double(self) as? T
        }
        else if T.self == Float.self {
            result = Float(self) as? T
        }
        else if let intType = T.self as? any FixedWidthInteger.Type {
            result = intType.init(self) as? T
        }
        return result ?? T.default
    }
}
