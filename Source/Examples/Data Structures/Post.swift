//
//  Post.swift
//  APIClient
//
//  Created by Jonathan Bailey on 6/20/20.
//  Copyright © 2020 Jonathan Bailey. All rights reserved.
//


/// When creating requests to any given API, you need to analyze the JSON objects and create `Decodable` structs which match them exactly.
internal struct Post: Codable {
    // NOTE: This object is `Codable`, because I want to be able to send this data in POST/PUT/PATCH requests as well.

    /// For this struct, all of the fields are primitive types, which are inherently `Decodable` (even when Optional), so this is a simple example.
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?

    // NOTE: For more complex objects, you may need to nest your `Decodable` structs inside of each other!
}
