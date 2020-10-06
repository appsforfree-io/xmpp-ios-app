//
//  XMLEncoder.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 05/10/2020.
//

import UIKit

enum XMLEncoderError: Error {
    case invalidXML
}

class XMLEncoder: XMPPEncoder {
    
    public func encode(_ value: Encodable) throws -> String {
        let xmlEncoding = XMLEncoding()
        try value.encode(to: xmlEncoding)
        return xmlFormat(from: xmlEncoding.data.xml, for: value)
    }
    
    private func xmlFormat(from xml: [String: String], for value: Encodable) -> String {
        var xmlString = "<\(T.self) ".lowercased()
        let attributesStrings = xml.map { "\($0)=\'\($1)\'" }
        xmlString += "\(attributesStrings.joined(separator: " "))>"
        print(xmlString)
        return xmlString
    }
    
}

fileprivate struct XMLEncoding: Encoder {
    
    fileprivate final class Data {
        private(set) var xml: [String: String] = [:]
        
        func encode(key codingKey: [CodingKey], value: String) {
            let key = codingKey.map { $0.stringValue }.joined(separator: ".")
            xml[key] = value
        }
    }
    
    fileprivate var data: Data
    
    init(to encodedData: Data = Data()) {
        self.data = encodedData
    }
    
    var codingPath: [CodingKey] = []
    
    let userInfo: [CodingUserInfoKey : Any] = [:]
    
    func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        var container = XMLKeyedEncoding<Key>(to: data)
        container.codingPath = codingPath
        return KeyedEncodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        var container = XMLUnkeyedEncoding(to: data)
        container.codingPath = codingPath
        return container
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        var container = XMLSingleValueEncoding(to: data)
        container.codingPath = codingPath
        return container
    }
    
}

fileprivate struct XMLKeyedEncoding<Key: CodingKey>: KeyedEncodingContainerProtocol {
    
    private let data: XMLEncoding.Data
    
    init(to data: XMLEncoding.Data) {
        self.data = data
    }
    
    var codingPath: [CodingKey] = []
    
    mutating func encodeNil(forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: "nil")
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value.description)
    }
    
    mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        var xmlEncoding = XMLEncoding(to: data)
        xmlEncoding.codingPath.append(key)
        try value.encode(to: xmlEncoding)
    }
    
    mutating func nestedContainer<NestedKey: CodingKey>(
        keyedBy keyType: NestedKey.Type,
        forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        var container = XMLKeyedEncoding<NestedKey>(to: data)
        container.codingPath = codingPath + [key]
        return KeyedEncodingContainer(container)
    }
    
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        var container = XMLUnkeyedEncoding(to: data)
        container.codingPath = codingPath + [key]
        return container
    }
    
    mutating func superEncoder() -> Encoder {
        let superKey = Key(stringValue: "super")!
        return superEncoder(forKey: superKey)
    }
    
    mutating func superEncoder(forKey key: Key) -> Encoder {
        var xmlEncoding = XMLEncoding(to: data)
        xmlEncoding.codingPath = codingPath + [key]
        return xmlEncoding
    }
}

fileprivate struct XMLUnkeyedEncoding: UnkeyedEncodingContainer {
    
    private let data: XMLEncoding.Data
    
    init(to data: XMLEncoding.Data) {
        self.data = data
    }
    
    var codingPath: [CodingKey] = []
    
    private(set) var count: Int = 0
    
    private mutating func nextIndexedKey() -> CodingKey {
        let nextCodingKey = IndexedCodingKey(intValue: count)!
        count += 1
        return nextCodingKey
    }
    
    private struct IndexedCodingKey: CodingKey {
        let intValue: Int?
        let stringValue: String
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = intValue.description
        }
        
        init?(stringValue: String) {
            return nil
        }
    }
    
    mutating func encodeNil() throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: "nil")
    }
    
    mutating func encode(_ value: Bool) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: String) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Double) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: Float) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: Int) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: Int8) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: Int16) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: Int32) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: Int64) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: UInt) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: UInt8) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: UInt16) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: UInt32) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode(_ value: UInt64) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value.description)
    }
    
    mutating func encode<T: Encodable>(_ value: T) throws {
        var xmlEncoding = XMLEncoding(to: data)
        xmlEncoding.codingPath = codingPath + [nextIndexedKey()]
        try value.encode(to: xmlEncoding)
    }
    
    mutating func nestedContainer<NestedKey: CodingKey>(
        keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> {
        var container = XMLKeyedEncoding<NestedKey>(to: data)
        container.codingPath = codingPath + [nextIndexedKey()]
        return KeyedEncodingContainer(container)
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        var container = XMLUnkeyedEncoding(to: data)
        container.codingPath = codingPath + [nextIndexedKey()]
        return container
    }
    
    mutating func superEncoder() -> Encoder {
        var xmlEncoding = XMLEncoding(to: data)
        xmlEncoding.codingPath.append(nextIndexedKey())
        return xmlEncoding
    }
    
}

fileprivate struct XMLSingleValueEncoding: SingleValueEncodingContainer {
    
    private let data: XMLEncoding.Data
    
    init(to data: XMLEncoding.Data) {
        self.data = data
    }
    
    var codingPath: [CodingKey] = []
    
    mutating func encodeNil() throws {
        data.encode(key: codingPath, value: "nil")
    }
    
    mutating func encode(_ value: Bool) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: String) throws {
        data.encode(key: codingPath, value: value)
    }
    
    mutating func encode(_ value: Double) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: Float) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: Int) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: Int8) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: Int16) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: Int32) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: Int64) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: UInt) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: UInt8) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: UInt16) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: UInt32) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode(_ value: UInt64) throws {
        data.encode(key: codingPath, value: value.description)
    }
    
    mutating func encode<T: Encodable>(_ value: T) throws {
        var xmlEncoding = XMLEncoding(to: data)
        xmlEncoding.codingPath = codingPath
        try value.encode(to: xmlEncoding)
    }
    
}
