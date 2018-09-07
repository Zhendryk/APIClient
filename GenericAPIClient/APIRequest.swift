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
    
    //If you want to mix and match encoded parameters and non encoded ones, just override the CodingKeys function like this:
    /*
     private enum CodingKeys: String, CodingKey {
        case [first property you want encoded]
        case [second property you want encoded]
        ...
     }
    */
}
