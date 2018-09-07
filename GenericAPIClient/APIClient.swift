//
//  APIClient.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

public class APIClient {
    private var baseURL: String
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    
    public init(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
    convenience init() {
        self.init("")
    }
    
    public func send<T: APIRequest>(request: T, completion: @escaping RequestCallback<T.Response>) -> URLSessionTask {
        let endpoint = self.endpoint(for: request)
        
        debugPrint("Sending API request for \(endpoint)")
        
        let task = session.dataTask(with: endpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                guard let data = data else { return }
                let result = try self.decoder.decode(T.Response.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
        return task
    }
    
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
        return URL(string: "\(baseURL)\(request.resource)?\(parameters)")!
    }
}
