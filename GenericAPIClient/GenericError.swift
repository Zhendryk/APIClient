//
//  GenericError.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

public enum GenericError: Error {
    case encoding
    case decoding
    case server(message: String)
}
