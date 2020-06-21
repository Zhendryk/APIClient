//
//  APIRequest.swift
//  APIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//
import Foundation


/// The protocol to which all API request types adhere.
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

    /// The URL path parameters of this request, as name:value pairs, if any.
    var urlPathParameters: [String : String] { get set }
}


/// A generic HTTP GET request.
open class GetRequest<T: Decodable> : APIRequest {
    public typealias ResponseType = T

    public var method: HTTPMethod { return .get }
    public var resource: String
    public var body: Data?
    public var headers: [String : String]
    public var urlQueryParameters: [URLQueryItem]
    public var urlPathParameters: [String : String]

    public init(resource: String, body: Data? = nil, headers: [String : String] = [:], urlQueryParameters: [URLQueryItem] = [], urlPathParameters: [String : String] = [:]) {
        self.resource = resource
        self.body = body
        self.headers = headers
        self.urlQueryParameters = urlQueryParameters
        self.urlPathParameters = urlPathParameters
        if !urlPathParameters.isEmpty {
            for urlPathParameter in urlPathParameters {
                self.resource = self.resource.replacingOccurrences(of: urlPathParameter.key, with: urlPathParameter.value)
            }
        }
    }
}

/// A generic HTTP POST request.
open class PostRequest<T: Decodable> : APIRequest {
    public typealias ResponseType = T

    public var method: HTTPMethod { return .post }
    public var resource: String
    public var body: Data?
    public var headers: [String : String]
    public var urlQueryParameters: [URLQueryItem]
    public var urlPathParameters: [String : String]

    public init(resource: String, body: Data? = nil, headers: [String : String] = [:], urlQueryParameters: [URLQueryItem] = [], urlPathParameters: [String : String] = [:]) {
        self.resource = resource
        self.body = body
        self.headers = headers
        self.urlQueryParameters = urlQueryParameters
        self.urlPathParameters = urlPathParameters
        if !urlPathParameters.isEmpty {
            for urlPathParameter in urlPathParameters {
                self.resource = self.resource.replacingOccurrences(of: urlPathParameter.key, with: urlPathParameter.value)
            }
        }
    }
}

/// A generic HTTP PUT request.
open class PutRequest<T: Decodable> : APIRequest {
    public typealias ResponseType = T

    public var method: HTTPMethod { return .put }
    public var resource: String
    public var body: Data?
    public var headers: [String : String]
    public var urlQueryParameters: [URLQueryItem]
    public var urlPathParameters: [String : String]

    public init(resource: String, body: Data? = nil, headers: [String : String] = [:], urlQueryParameters: [URLQueryItem] = [], urlPathParameters: [String : String] = [:]) {
        self.resource = resource
        self.body = body
        self.headers = headers
        self.urlQueryParameters = urlQueryParameters
        self.urlPathParameters = urlPathParameters
        if !urlPathParameters.isEmpty {
            for urlPathParameter in urlPathParameters {
                self.resource = self.resource.replacingOccurrences(of: urlPathParameter.key, with: urlPathParameter.value)
            }
        }
    }
}

/// A generic HTTP PATCH request.
open class PatchRequest<T: Decodable> : APIRequest {
    public typealias ResponseType = T

    public var method: HTTPMethod { return .patch }
    public var resource: String
    public var body: Data?
    public var headers: [String : String]
    public var urlQueryParameters: [URLQueryItem]
    public var urlPathParameters: [String : String]

    public init(resource: String, body: Data? = nil, headers: [String : String] = [:], urlQueryParameters: [URLQueryItem] = [], urlPathParameters: [String : String] = [:]) {
        self.resource = resource
        self.body = body
        self.headers = headers
        self.urlQueryParameters = urlQueryParameters
        self.urlPathParameters = urlPathParameters
        if !urlPathParameters.isEmpty {
            for urlPathParameter in urlPathParameters {
                self.resource = self.resource.replacingOccurrences(of: urlPathParameter.key, with: urlPathParameter.value)
            }
        }
    }
}

/// A generic HTTP DELETE request.
open class DeleteRequest<T: Decodable> : APIRequest {
    public typealias ResponseType = T

    public var method: HTTPMethod { return .delete }
    public var resource: String
    public var body: Data?
    public var headers: [String : String]
    public var urlQueryParameters: [URLQueryItem]
    public var urlPathParameters: [String : String]

    public init(resource: String, body: Data? = nil, headers: [String : String] = [:], urlQueryParameters: [URLQueryItem] = [], urlPathParameters: [String : String] = [:]) {
        self.resource = resource
        self.body = body
        self.headers = headers
        self.urlQueryParameters = urlQueryParameters
        self.urlPathParameters = urlPathParameters
        if !urlPathParameters.isEmpty {
            for urlPathParameter in urlPathParameters {
                self.resource = self.resource.replacingOccurrences(of: urlPathParameter.key, with: urlPathParameter.value)
            }
        }
    }
}
