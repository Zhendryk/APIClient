//
//  Test.swift
//  APIClient
//
//  Created by Jonathan Bailey on 6/20/20.
//  Copyright © 2020 Jonathan Bailey. All rights reserved.
//
import Foundation

/// A simple GET request, fetching the posts of a specific user from a test API.
internal class GetPosts: GetRequest<[Post]> {

    init(userId: Int) {
        super.init(resource: "/posts", urlQueryParameters: [URLQueryItem(name: "userId", value: HTTPParameter.int(userId).description)])
    }
}
