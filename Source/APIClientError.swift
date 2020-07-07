//
//  APIClientError.swift
//  APIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//


/// An error resulting from an operation failing during normal APIClient operation.
public enum APIClientError: Error {
    /// An error occurred during decoding.
    case decoding

    /// A request url was malformed
    case malformedUrl
}
