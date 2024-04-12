//
//  Default.swift
//  SweetCodable
//
//  Created by jowsing on 2024/4/12.
//

import Foundation

public typealias CodeDefaultable = Codable & Defaultable

@propertyWrapper
public struct Default<Value: CodeDefaultable> {
    
    public var wrappedValue: Value
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

extension Default: Codable {
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(Value.self)) ?? Value.default
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    
    public func decode<T>(_ type: Default<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Default<T> where T : CodeDefaultable {
        return try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.default)
    }
}

extension UnkeyedDecodingContainer {
    
    public mutating func decode<T>(_ type: Default<T>.Type) throws -> Default<T> where T : CodeDefaultable {
        return try decodeIfPresent(type) ?? Default(wrappedValue: T.default)
    }
}
