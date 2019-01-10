//
//  APIClient.swift
//  GenericAPIClient
//
//  Created by Jonathan Bailey on 9/6/18.
//  Copyright © 2018 Jonathan Bailey. All rights reserved.
//

import Foundation

open class APIClient {
    private var baseURL: String
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
    
    public init(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
    convenience init() {
        self.init("")
    }
    
    @discardableResult
    public func send<T: APIRequest>(request: T, completion: @escaping RequestCallback<T.Response>) -> URLSessionTask {
        let endpoint = self.endpoint(for: request, overrideEncoding: request.overrideEncoding)
        
        print("\(dateFormatter.string(from: Date())) API Request sent: \(endpoint)")
        
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
    
    private func endpoint<T: APIRequest>(for request: T, overrideEncoding: Bool) -> URL {
        var endpoint: String = "\(baseURL)\(request.resource)"
        if !request.extraPathComponents.isEmpty {
            for component in request.extraPathComponents {
                endpoint.append("/\(component)")
            }
        }
        if overrideEncoding {
            return URL(string: endpoint)!
        }
        else {
            guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
            return URL(string: "\(endpoint)?\(parameters)")!
        }
    }
}
