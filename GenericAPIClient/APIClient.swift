//
//  APIClient.swift
//  GenericAPIClient
//
//  Created by Zhendryk on 8/31/18.
//  Copyright © 2018 Zhendryk. All rights reserved.
//

/// The protocol for all endpoint clients to conform to
protocol APIClient {
    var session: URLSession { get }
    func makeWebRequest<T: Decodable>(to url: String, with pathComponents: [String], with queryItems: [URLQueryItem], decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}


// MARK: - Extension to APIClient protocol, adds JSONTaskCompletionHandler typealias
extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
}


/// The base class for all endpoint clients
open class Client : APIClient {
    
    /// The URLSession to interact with the API server for this client
    var session: URLSession
    
    /// Initializes this client with a custom URLSessionConfiguration
    ///
    /// - Parameter configuration: A custom URLSessionConfiguration
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    /// Initializes this client with the default URLSessionConfiguration
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    /// Creates and sends an outgoing web request to the given url with the given path components attached, optional query items such as api keys available
    ///
    /// - Parameters:
    ///   - url: The base url you want to send the web request to
    ///   - pathComponents: Any endpoint path components to add to the base url
    ///   - queryItems: Any additional query items such as an authorization key, pagination number, etc
    ///   - decode: Callback function to parse the JSON into a generic decodable object
    ///   - completion: Callback function to handle the JSON data in the form of Result<T, APIError>
    func makeWebRequest<T: Decodable>(to url: String, with pathComponents: [String], with queryItems: [URLQueryItem] = [], decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        guard var urlOut = URL(string: url) else {
            completion(Result.failure(APIError.urlCreationFailure))
            return
        }
        for component in pathComponents {
            urlOut.appendPathComponent(component)
        }
        guard var c = URLComponents(url: urlOut, resolvingAgainstBaseURL: false) else {
            completion(Result.failure(APIError.urlComponentsFailure))
            return
        }
        c.queryItems = queryItems
        guard let urlFinal = c.url else {
            completion(Result.failure(APIError.urlCreationFailure))
            return
        }
        if(!isValidURL(url: urlFinal)) { completion(Result.failure(APIError.urlValidationFailure)) }
        
        let request = URLRequest(url: urlFinal)
        fetchAsync(with: request, decode: decode, completion: completion)
    }
    
    /// Fetches JSON data for any given endpoint from the API
    ///
    /// - Parameters:
    ///   - request: URLRequest for the API endpoint
    ///   - decode: Callback function to parse the JSON into a generic decodable object
    ///   - completion: Callback function to handle the JSON data in the form of Result<T, APIError>
    private func fetchAsync<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decode: T.self) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
    
    /// URLSession data task to decode JSON data
    ///
    /// - Parameters:
    ///   - request: The URLRequest that is getting the JSON data
    ///   - objectType: The type of data to decode
    ///   - completion: Callback function to handle (Decodable?, APIError?) -> Void
    /// - Returns: URLSessionDataTask to be used by fetchAsync function
    private func decodingTask<T: Decodable>(with request: URLRequest, decode objectType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(objectType, from: data)
                        completion(genericModel, nil)
                    } catch let jsonError {
                        print("JSON Error: \(jsonError.localizedDescription)")
                        completion(nil, .jsonConversionFailure)
                    }
                }
                else {
                    completion(nil, .invalidData)
                }
            }
            else {
                print("HTTP Error: Code \(httpResponse.statusCode)\n")
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    
    /// Ensures the validity of a given url
    ///
    /// - Parameter url: The url to validate
    /// - Returns: True if valid, false if not
    private func isValidURL(url: URL) -> Bool {
        return UIApplication.shared.canOpenURL(url)
    }
    
    /// Determines if the given string is percent encoded for a url
    ///
    /// - Parameter urlString: The string to validate
    /// - Returns: True if it is percent encoded, false if not
    private func isPercentEncoded(urlString: String) -> Bool {
        return urlString.removingPercentEncoding != urlString
    }
    
    /// Encodes a string using percent encoding and creates a URLRequest from it
    ///
    /// - Parameter urlString: The string to encode
    /// - Returns: A valid URLRequest if successful, nil if optional values fail
    private func encodeToURLRequest(urlString: String) -> URLRequest? {
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        guard let encodedURL = URL(string: encodedString) else { return nil }
        return URLRequest(url: encodedURL)
    }
}
