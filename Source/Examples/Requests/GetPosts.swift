//
//  Test.swift
//  APIClient
//
//  Created by Jonathan Bailey on 6/20/20.
//  Copyright © 2020 Jonathan Bailey. All rights reserved.
//
import Foundation


/// A simple GET request, fetching the posts of a specific user from a test API.
internal struct GetPosts: APIRequest {
    /// Our expected data to be returned is an Array of `Post` objects. See `Post.swift` for the structure.
    typealias ResponseType = [Post]

    /// This is a GET request, so we mark it accordingly.
    var method: HTTPMethod { return .get }

    /// Because this is a GET request, we don't have any body data to incorporate.
    var body: Data? = nil

    /// We're not going to include any headers for this request.
    var headers: [String : String] = [:]

    /// The endpoint resource we're querying. NOTE: The preceeding forward slash is REQUIRED.
    var resource: String = "/posts"

    /// The possible URL query parameters for this request. NOTE: Instantiate them in the constructor for this request as you can see below.
    var urlQueryParameters: [URLQueryItem] = []

    /// Constructor for a `GetPosts` request, which would look like this: "scheme://host<resource>?<urlQueryParameters>". You want to initialize any variable parameters here that are dynamic in the URL.
    /// - Parameter userId: The userId to search for posts for.
    init(userId: Int) {
        // Just append each of your dynamic URL query parameters to the list here.
        // NOTE: You can either use the provided HTTPParameter class, or just pass in a string representation of the value for your parameter.
        self.urlQueryParameters.append(URLQueryItem(name: "userId", value: HTTPParameter.int(userId).description))
    }
}
