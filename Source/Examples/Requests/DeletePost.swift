//
//  DeletePost.swift
//  APIClient
//
//  Created by Jonathan Bailey on 6/20/20.
//  Copyright © 2020 Jonathan Bailey. All rights reserved.
//
import Foundation

/// A simple DELETE request, deleting the post associated with an id.
internal struct DeletePost: APIRequest {
    /// The API we're querying doesn't return any data upon a DELETE.
    typealias ResponseType = NoResponse

    /// This is a DELETE request, so we mark it accordingly.
    var method: HTTPMethod { return .delete }

    /// Because this is a DELETE request, we don't have any body data to incorporate.
    var body: Data? = nil

    /// We're not going to include any headers for this request.
    var headers: [String : String] = [:]

    /// The endpoint resource we're querying. NOTE: The preceeding forward slash is REQUIRED.
    var resource: String = "/posts"

    /// The possible URL query parameters for this request. NOTE: Instantiate them in the constructor for this request as you can see below.
    var urlQueryParameters: [URLQueryItem] = []

    /// Constructor for a `DeletePost` request, which would look like this: "scheme://host/posts/<postId>". You want to initialize any variable parameters here that are dynamic in the URL.
    /// - Parameter postId: The id of the post to delete.
    init(postId: Int) {
        // This specific API addresses posts by scheme://host/posts/<postId>
        self.resource = [self.resource, String(describing: postId)].joined(separator: "/")
    }
}
