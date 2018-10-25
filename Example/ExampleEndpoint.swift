//
//  ExampleEndpoint.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 10/25/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

struct GetExample: APIRequest {
    typealias Response = String // The datatype of the JSON object you are getting goes here, can also be a decodable struct
    
    var resource: String { return "/example" } // The endpoint url that gets attached to the end of the base URL for the API goes here
    var overrideEncoding: Bool { return false } // Set this to true if you have no endpoint parameters or if you have extra path components
    var extraPathComponents: [String] = [] // This will hold path components that are appended like this: /component1/component2... Used for path components that have variable values at runtime
    
    private let exampleParameter: Int // This is an example of a parameter, so this would be appended to the end of the url like this: api.example.com/v1/exampleEndpoint?exampleParameter=...
    
    // Add all of your parameters here
    private enum CodingKeys: String, CodingKey {
        case exampleParameter
    }
    
    init(exampleParameter: Int, exampleExtraPathComponent: String) {
        self.exampleParameter = exampleParameter
        self.extraPathComponents.append(exampleExtraPathComponent) // Append these in the order they come in the URL
    }
}
