//
//  URLSession+Result.swift
//  APIClient
//
//  Created by Jonathan Bailey on 7/7/20.
//

import Foundation

extension URLSession {

    /// Create a `URLSessionDataTask` using the given `URLRequest` and return the result as a `Result<(URLResponse, Data), Error>`.
    /// - Parameter urlRequest: The `URLRequest` to send
    /// - Parameter result: Completion handler which returns a `Result<(URLResponse, Data), Error>`
    func dataTask(with urlRequest: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                result(.failure(error))
            }
            else {
                if let response = response, let data = data {
                    result(.success((response, data)))
                }
                else {
                    let error = NSError(domain: "error", code: 0, userInfo: nil)
                    result(.failure(error))
                }
            }
        }
    }
}
