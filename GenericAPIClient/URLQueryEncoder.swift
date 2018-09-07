//
//  URLQueryEncoder.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

public enum URLQueryEncoder {
    static func encode<T: Encodable>(_ encodable: T) throws -> String {
        let parameterData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parameterData)
        return parameters.map({ "\($0)=\($1)" }).joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
