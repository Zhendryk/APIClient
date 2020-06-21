//
//  HTTPParameter.swift
//  APIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

/// Codable parameter value for URL query parameters. To get their URLsafe string, access the `.description` field.
public enum HTTPParameter: Codable, CustomStringConvertible {
    case string(String)
    case stringArr([String])
    case bool(Bool)
    case boolArr([Bool])
    case int(Int)
    case intArr([Int])
    case double(Double)
    case doubleArr([Double])
    case float(Float)
    case floatArr([Float])

    public init(from decoder: Decoder) throws {
        // Grab a single primitive value view of this decoder
        let container = try decoder.singleValueContainer()
        // Initialize our value by decoding our single primitive to an HTTPParameter
        if let string = try? container.decode(String.self) { self = .string(string) }
        else if let stringArr = try? container.decode([String].self) { self = .stringArr(stringArr) }
        else if let bool = try? container.decode(Bool.self) { self = .bool(bool) }
        else if let boolArr = try? container.decode([Bool].self) { self = .boolArr(boolArr) }
        else if let int = try? container.decode(Int.self) { self = .int(int) }
        else if let intArr = try? container.decode([Int].self) { self = .intArr(intArr) }
        else if let double = try? container.decode(Double.self) { self = .double(double) }
        else if let doubleArr = try? container.decode([Double].self) { self = .doubleArr(doubleArr) }
        else if let float = try? container.decode(Float.self) { self = .float(float) }
        else if let floatArr = try? container.decode([Float].self) { self = .floatArr(floatArr) }
        // We couldn't decode successfully, so throw a decoding error
        else { throw APIClientError.decoding }
    }

    public func encode(to encoder: Encoder) throws {
        // Encoding a single primitive value
        var container = encoder.singleValueContainer()
        switch(self) {
        case .string(let str):
            try container.encode(str)
            break
        case .stringArr(let strArr):
            try container.encode(strArr)
            break
        case .bool(let bool):
            try container.encode(bool)
            break
        case .boolArr(let boolArr):
            try container.encode(boolArr)
            break
        case .int(let int):
            try container.encode(int)
            break
        case .intArr(let intArr):
            try container.encode(intArr)
            break
        case .double(let double):
            try container.encode(double)
            break
        case .doubleArr(let doubleArr):
            try container.encode(doubleArr)
            break
        case .float(let float):
            try container.encode(float)
            break
        case .floatArr(let floatArr):
            try container.encode(floatArr)
            break
        }
    }

    /// The serialized representation of this HTTPParameter, suitable for use in an APIRequest.
    public var description: String {
        switch self {
        case .string(let string): return string
        case .stringArr(let stringArr): return stringArr.joined(separator: ", ").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .bool(let bool): return String(describing: bool)
        case .boolArr(let boolArr):
            var str: [String] = []
            for bl in boolArr {
                str.append(String(describing: bl))
            }
            return str.joined(separator: ", ").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .int(let int): return String(describing: int)
        case .intArr(let intArr):
            var str: [String] = []
            for num in intArr {
                str.append(String(describing: num))
            }
            return str.joined(separator: ", ").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .double(let double): return String(describing: double)
        case .doubleArr(let doubleArr):
            var str: [String] = []
            for dbl in doubleArr {
                str.append(String(describing: dbl))
            }
            return str.joined(separator: ", ").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .float(let float): return String(describing: float)
        case .floatArr(let floatArr):
            var str: [String] = []
            for flt in floatArr {
                str.append(String(describing: flt))
            }
            return str.joined(separator: ", ").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
}
