//
//  URLRequest.swift
//  
//
//  Created by Marvin Peter on 8/3/20.
//

import Foundation

extension URLRequest {

    /// Create a custom URL request object
    /// - Parameters:
    ///   - url: URL
    ///   - headers: HTTP request headers
    ///   - method: HTTP Method
    ///   - body: Request body
    init(url: URL, headers: [String: String], method: String, body: Data?) {
        var req = URLRequest(url: url)
        req.httpMethod = method
        req.httpBody = body

        for (k, v) in headers {
            req.setValue(v, forHTTPHeaderField: k)
        }

        self = req
    }
}
