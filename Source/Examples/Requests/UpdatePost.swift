//
//  UpdatePost.swift
//  APIClient
//
//  Created by Jonathan Bailey on 6/20/20.
//  Copyright © 2020 Jonathan Bailey. All rights reserved.
//
import Foundation

/// A simple PUT request, updating an existing post associated with a given userId.
internal class UpdatePostPut: PutRequest<NoResponse> {

    init(newPost: Post) {
        let encoded = try! JSONEncoder().encode(newPost)
        let jsonString = String(data: encoded, encoding: .utf8)!
        let body = Data(base64Encoded: jsonString)
        super.init(resource: "/posts", body: body, headers: ["Content-Type" : "application/json; charset=UTF-8"])
    }
}

/// A simple PATCH request, updating an existing post associated with a given userId.
internal class UpdatePostPatch: PatchRequest<NoResponse> {

    init(newPost: Post) {
        let encoded = try! JSONEncoder().encode(newPost)
        let jsonString = String(data: encoded, encoding: .utf8)!
        let body = Data(base64Encoded: jsonString)
        super.init(resource: "/posts", body: body, headers: ["Content-Type" : "application/json; charset=UTF-8"])
    }
}
