//
//  HTTPParameter.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

public enum HTTPParameter: Decodable, CustomStringConvertible {
    case string(String)
    case stringArr([String])
    case bool(Bool)
    case int(Int)
    case intArr([Int])
    case double(Double)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) { self = .string(string) }
        else if let stringArr = try? container.decode([String].self) { self = .stringArr(stringArr) }
        else if let bool = try? container.decode(Bool.self) { self = .bool(bool) }
        else if let int = try? container.decode(Int.self) { self = .int(int) }
        else if let intArr = try? container.decode([Int].self) { self = .intArr(intArr) }
        else if let double = try? container.decode(Double.self) { self = .double(double) }
        else { throw GenericError.decoding }
    }
    
    public var description: String {
        switch self {
        case .string(let string): return string
        case .stringArr(let stringArr): return stringArr.joined(separator: ", ")
        case .bool(let bool): return String(describing: bool)
        case .int(let int): return String(describing: int)
        case .intArr(let intArr):
            var str: [String] = []
            for num in intArr {
                str.append(String(num))
            }
            return str.joined(separator: ", ")
        case .double(let double): return String(describing: double)
        }
    }
}
