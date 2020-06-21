//
//  APIClient.swift
//  APIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//
import Foundation

/// A generic client interface to interact with an API. Can be subclassed if you wish.
open class APIClient {
    /// The `URLComponents` object used to create URLs to make requests to an API.
    private var urlComponents = URLComponents()

    /// The `URLSession` to use to send web requests.
    private let session = URLSession(configuration: .default)

    /// The `JSONDecoder` to decode the responses we get from our requests.
    private let decoder = JSONDecoder()

    /// Date formatter, purely for internal logging purposes.
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    /// Create an `APIClient` with the given `host`.
    /// - Parameter host: The hostname of the API you wish to interact with, e.g. `api.github.com`, etc.
    public init(_ host: String, scheme: String = "https") {
        self.urlComponents.host = host
        self.urlComponents.scheme = scheme
    }

    /// The host this `APIClient` is interfacing with.
    public var host: String? {
        return self.urlComponents.host
    }

    /// Set the host for this `APIClient` to interface with.
    /// - Parameter newHost: The host of the API this `APIClient` is interfacing with.
    public func setHost(_ newHost: String?) {
        self.urlComponents.host = newHost
    }

    /// The scheme of the URLs used when making requests with this `APIClient`.
    public var scheme: String? {
        return self.urlComponents.scheme
    }

    /// Set the URL scheme to use when making requests with this `APIClient`.
    /// - Parameter newScheme: The new URL scheme.
    public func setScheme(_ newScheme: String?) {
        self.urlComponents.scheme = newScheme
    }

    /// Send a web request to the endpoint defined by `request`, and handle the response with the callback handler `completion`.
    /// - Parameter request: The generic object conforming to the `APIRequest` protocol defining the specific endpoint / request we want to send.
    /// - Parameter logOutput: Whether or not there should be any stdout logs during this request. Defaults to `true`.
    /// - Parameter completion: Completion handler (callback) to handle the response of the request that is sent.
    @discardableResult
    public func send<T: APIRequest>(request: T, logOutput: Bool = true, completion: @escaping RequestCallback<T.ResponseType>) -> URLSessionTask? {
        // Generate our endpoint by serializing all of the data within request.
        var requestUrl = URLComponents()
        requestUrl.host = self.urlComponents.host
        requestUrl.scheme = self.urlComponents.scheme
        requestUrl.path = request.resource
        requestUrl.queryItems = request.urlQueryParameters
        guard let endpointUrl = requestUrl.url else {
            completion(.failure(APIClientError.malformedUrl))
            return nil
        }
        // Construct our web request.
        var webRequest = URLRequest(url: endpointUrl)
        webRequest.httpMethod = request.method.rawValue
        webRequest.httpBody = request.body
        for header in request.headers {
            webRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        // Handle the response to our request.
        if logOutput { print("\(dateFormatter.string(from: Date())) - API \(request.method.rawValue) Request sent: \(endpointUrl)") }
        let task = session.dataTask(with: webRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let err = error {
                completion(.failure(err))
            }
            else {
                do {
                    // Successful request, attempt to decode the response and pass the data to the completion handler.
                    if T.ResponseType.self == NoResponse.self {
                        // Don't care about response data (if any), just complete with nil.
                        completion(.success(nil))
                        return
                    }
                    else {
                        // Decode the response data and complete with it.
                        guard let data = data else {
                            completion(.failure(APIClientError.decoding))
                            return
                        }
                        let result = try self.decoder.decode(T.ResponseType.self, from: data)
                        completion(.success(result))
                    }
                }
                catch {
                    // Unsuccessful request, complete with the resulting error.
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        return task
    }
}
