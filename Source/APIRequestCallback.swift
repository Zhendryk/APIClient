//
//  APIRequestCallback.swift
//  APIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

/// Simple callback typealias mapping a method which takes an API call result and returns nothing.
public typealias APIRequestCallback<T> = (Result<(URLResponse, T), Error>) -> Void

/// Struct to differentiate requests that aren't expecting a response
public struct NoResponse: Decodable {
    init() {}
}
