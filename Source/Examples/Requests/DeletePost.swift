//
//  DeletePost.swift
//  APIClient
//
//  Created by Jonathan Bailey on 6/20/20.
//  Copyright © 2020 Jonathan Bailey. All rights reserved.
//
import Foundation

/// A simple DELETE request, deleting the post associated with an id.
internal class DeletePost: DeleteRequest<NoResponse> {

    init(postId: Int) {
        super.init(resource: "/posts/:id", urlPathParameters: [":id" : String(describing: postId)])
    }
}
