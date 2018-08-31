//
//  Result.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 8/31/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

/// Indicates either successful task completion or a task failure
///
/// - success: Task was successful, returns generic type T
/// - failure: Task failed, returns generic error U
public enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
