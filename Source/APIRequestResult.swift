//
//  APIRequestResult.swift
//  APIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//


/// The result of an API request, providing a Value when successful and an Error when it fails.
public enum APIRequestResult<Value> {
    case success(Value?)
    case failure(Error)
}

/// Simple callback typealias mapping a method which takes an API call result and returns nothing.
public typealias RequestCallback<Value> = (APIRequestResult<Value>) -> Void

/// Struct to differentiate requests that aren't expecting a response
public struct NoResponse: Decodable {}
