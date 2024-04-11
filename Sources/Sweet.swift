//
//  Sweet.swift
//  Sweet
//
//  Created by jowsing on 2024/4/11.
//

import Foundation

public typealias Sweetable = Codable & Defaultable

@propertyWrapper
public struct Sweet<Value: Sweetable> {
    public var wrappedValue: Value
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

extension Sweet: Codable {
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Value.self) {
            wrappedValue = value
        } else {
            var types: [Convertable.Type] = [Bool.self, Int.self, UInt.self, Double.self, String.self]
            if let index = types.firstIndex(where: { $0 == Value.self }) {
                types.remove(at: index)
            }
            var result: Value?
            for type in types {
                if let value = try? container.decode(type) {
                    result = value.convert()
                    break
                }
            }
            wrappedValue = result ?? Value.default
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    
    public func decode<T>(_ type: Sweet<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Sweet<T> where T : Sweetable {
        return try decodeIfPresent(type, forKey: key) ?? Sweet(wrappedValue: T.default)
    }
}

extension UnkeyedDecodingContainer {
    
    public mutating func decode<T>(_ type: Sweet<T>.Type) throws -> Sweet<T> where T : Sweetable {
        return try decodeIfPresent(type) ?? Sweet(wrappedValue: T.default)
    }
}
