//
//  Response.swift
//  
//
//  Created by Marvin Peter on 8/3/20.
//

import Foundation

public struct NoNetworkConnectionError: Error { }


/// Structure representing a server response.
public struct Response {
    
    /// Headers associated with the response.
    public let headers: [String: String]

    /// The status code of the response.
    public let status: Int

    /// The requested URL
    public let url: URL

    /// Error information in case the request failed
    public let error: Error?

    /// Returns the raw response object
    public let response: HTTPURLResponse?
    
    /// Return all cookies associated with the requested domain
    public var cookies: [String: String] {
        Dictionary(uniqueKeysWithValues: HTTPCookieStorage.shared.cookies!
                .filter { $0.domain == url.host! }
                .map { ($0.name, $0.value) })
    }

    private let body: Data?

    
    /// Create a new successful response object. (Do not use this unless required for some reason, only fetch should return a Response object.)
    /// - Parameters:
    ///   - url: Requested URL
    ///   - data: Request body
    ///   - res: Native response object
    public init(url: URL, data: Data?, response res: HTTPURLResponse) {
        self.headers = res.allHeaderFields as? [String: String] ?? [:]
        self.status = res.statusCode
        self.url = res.url ?? url
        self.response = res
        self.body = data
        self.error = nil
    }

    
    /// Create a new failed response object. (Do not use this unless required for some reason, only fetch should return a Response object.)
    /// - Parameters:
    ///   - url: Requested URL
    ///   - error: Error
    ///   - status: Status code
    public init(url: URL, error: Error, status: Int = -1) {
        self.headers = [:]
        self.status = status
        self.url = url
        self.response = nil
        self.body = nil
        self.error = error
    }

    /// Indicates whether the response was successful (status in the range 200–299) or not.
    var ok: Bool {
        status >= 200 && status <= 299
    }

    /// Get the response body
    /// - Returns: Data
    public var data: Data? {
        autoreleasepool {
            self.body
        }
    }

    /// Decode the response body to text using UTF8
    /// - Returns: Text representation
    public var text: String? {
        text(encoding: .utf8)
    }

    /// Decode the response body to text
    /// - Parameter encoding: Encoding
    /// - Returns: Text representation
    public func text(encoding: String.Encoding) -> String? {
        guard let data = self.data else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }

    /// Parse body into an decodable object
    /// - Parameter type: Target type
    /// - Returns: Parsed object
    public func json<T: Decodable>(_ type: T.Type) -> T? {
        guard let data = self.data else {
            return nil
        }
        
        guard let res = try? JSONDecoder().decode(type, from: data) else {
            return nil
        }
        
        return res
    }
}
