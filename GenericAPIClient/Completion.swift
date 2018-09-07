//
//  Completion.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

func completion<T>(onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void) -> RequestCallback<T> {
    return { result in
        switch result {
        case .success(let value):
            onSuccess(value)
        case .failure(let error):
            onError(error)
//        default:
//            onError(SplitError.NoResultFound)
        }
        
    }
}

func completion(onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void) -> ((Bool) -> Void) {
    return { success in 
        if success { onSuccess() }
        else { onFailure() }
    }
}

enum SplitError: Error {
    case NoResultFound
}
