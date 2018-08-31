//
//  APIError.swift
//  GenericAPIClient
//
//  Created by Zhendryk on 8/31/18.
//  Copyright © 2018 Zhendryk. All rights reserved.
//

/// All possible failures that can occur during API querying
public enum APIError: Error {
    case urlCreationFailure
    case urlValidationFailure
    case urlComponentsFailure
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case needsAuthorizationError
    case authorizationAttachmentFailure
    case queryParameterAttachmentFailure
    case queryEncodingError
    
    
    /// Detailed description of the failure
    var localizedDescription: String {
        switch self {
        case .urlCreationFailure: return "Attempt to create URL from string failed"
        case .urlValidationFailure: return "Supplied URL failed validation, not a valid URL"
        case .urlComponentsFailure: return "Failure to create components from url"
        case .requestFailed: return "API request failed"
        case .invalidData: return "Invalid data"
        case .responseUnsuccessful: return "API response unsuccessful"
        case .jsonParsingFailure: return "JSON parsing failure"
        case .jsonConversionFailure: return "JSON conversion failure"
        case .needsAuthorizationError: return "Request needs authorization key and one was either not supplied or is invalid."
        case .authorizationAttachmentFailure: return "Failed to attach authorization key to request, make sure the API key is a valid one."
        case .queryParameterAttachmentFailure: return "Failed to attach one or more query parameters to request, make sure they were properly formatted."
        case .queryEncodingError: return "Failed to properly encode the string for the API query."
        }
    }
}
