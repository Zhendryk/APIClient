//
//  APIRequest.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var resource: String { get }
    var overrideEncoding: Bool { get }
    var extraPathComponents: [String] { get set }
}
