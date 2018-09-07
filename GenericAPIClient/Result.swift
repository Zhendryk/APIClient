//
//  Result.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public typealias RequestCallback<Value> = (Result<Value>) -> Void
