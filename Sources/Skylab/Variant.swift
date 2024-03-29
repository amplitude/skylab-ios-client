//
//  Variant.swift
//  Skylab
//
//  Created by Curtis Liu on 1/20/21.
//

import Foundation

public struct Variant {
    public let value: String
    public let payload: Any?

    public init(_ value: String, payload: Any? = nil) {
        self.value = value
        self.payload = payload
    }

    init?(json: [String: Any]) {
        let key = json["key"] as? String
        let value = json["value"] as? String
        if (key == nil && value == nil) {
            return nil
        }
        self.value = (value ?? key)!
        self.payload = json["payload"]
    }
}

extension Variant : Codable {
    
    enum CodingKeys: String, CodingKey {
        case value
        case payload
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try values.decode(String.self, forKey: .value)
        if let data = try? values.decode(Data.self, forKey: .payload),
           let objectPayload = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            self.payload = objectPayload["payload"] ?? nil
        } else {
            self.payload = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        let objectPayload = ["payload": self.payload]
        if let data = try? JSONSerialization.data(withJSONObject: objectPayload, options: []) {
            try container.encode(data, forKey: .payload)
        } else {
            try container.encodeNil(forKey: .payload)
        }
    }
}
