//
//  UpdatePost.swift
//  APIClient
//
//  Created by Jonathan Bailey on 6/20/20.
//  Copyright © 2020 Jonathan Bailey. All rights reserved.
//
import Foundation

/// A simple PUT request, updating an existing post associated with a given userId.
internal struct UpdatePostPut: APIRequest {
    /// The endpoint we're querying will not return any data upon an update.
    typealias ResponseType = NoResponse

    /// This is a PUT request, so we mark it accordingly.
    var method: HTTPMethod { return .put }

    /// Because this is a PUT request, we can initialize this to nil, but we'll want to populate it with our dynamic data in our constructor below.
    var body: Data? = nil

    /// Because we're updating data, we want to tell the server what kind of data it should expect. Add that as a 'Content-Type' header.
    var headers: [String : String] = ["Content-Type" : "application/json; charset=UTF-8"]

    /// The endpoint resource we're querying. NOTE: The preceeding forward slash is REQUIRED.
    var resource: String = "/posts"

    /// The possible URL query parameters for this request. NOTE: Instantiate them in the constructor for this request as you can see below.
    var urlQueryParameters: [URLQueryItem] = []


    /// Constructor for a `UpdatePostPut` request, which would look like this: "scheme://host/posts?". You want to initialize any variable parameters here that are dynamic in the URL.
    /// - Parameter newPost: The new data to update the post with.
    init(newPost: Post) {
        // We want to encode our body data. Note the force unwrapping due to the fact that we know our object is encodable.
        let encoded = try! JSONEncoder().encode(newPost)
        let jsonString = String(data: encoded, encoding: .utf8)!
        self.body = Data(base64Encoded: jsonString)
    }
}

/// A simple PATCH request, updating an existing post associated with a given userId.
struct UpdatePostPatch: APIRequest {
    /// The endpoint we're querying will not return any data upon an update.
    typealias ResponseType = NoResponse

    /// This is a PATCH request, so we mark it accordingly.
    var method: HTTPMethod { return .patch }

    /// Because this is a PATCH request, we can initialize this to nil, but we'll want to populate it with our dynamic data in our constructor below.
    var body: Data? = nil

    /// Because we're updating data, we want to tell the server what kind of data it should expect. Add that as a 'Content-Type' header.
    var headers: [String : String] = ["Content-Type" : "application/json; charset=UTF-8"]

    /// The endpoint resource we're querying. NOTE: The preceeding forward slash is REQUIRED.
    var resource: String = "/posts"

    /// The possible URL query parameters for this request. NOTE: Instantiate them in the constructor for this request as you can see below.
    var urlQueryParameters: [URLQueryItem] = []


    /// Constructor for a `UpdatePostPatch` request, which would look like this: "scheme://host/posts?". You want to initialize any variable parameters here that are dynamic in the URL.
    /// - Parameter newPost: The new data to update the post with.
    init(newPost: Post) {
        // We want to encode our body data. Note the force unwrapping due to the fact that we know our object is encodable.
        let encoded = try! JSONEncoder().encode(newPost)
        let jsonString = String(data: encoded, encoding: .utf8)!
        self.body = Data(base64Encoded: jsonString)
    }
}
