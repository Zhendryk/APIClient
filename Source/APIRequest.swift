//
//  APIRequest.swift
//  APIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//
import Foundation


/// Generic API request
public protocol APIRequest {
    
    /// Placeholder `Decodable` representing what the expected response type to this `APIRequest` should be.
    associatedtype ResponseType: Decodable

    /// The HTTP request method to use for this request.
    var method: HTTPMethod { get }

    /// Optional data to include in the request body, usually for HTTP POST/PUT requests.
    var body: Data? { get set }

    /// Optional headers to include in your request.
    var headers: [String : String] { get set }

    /// The endpoint resource of this API request e.g. `scheme://host<RESOURCE>` where <RESOURCE> could be `/info`, etc. NOTE: The preceeding forward slash is required.
    var resource: String { get set }

    /// The URL query parameters of this request, if any.
    var urlQueryParameters: [URLQueryItem] { get }
}
