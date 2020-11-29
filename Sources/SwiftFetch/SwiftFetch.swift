//
//  SwftFetch.swift
//
//
//  Created by Marvin Peter on 8/3/20.
//

import Foundation

/// Fetch web resource asynchronous
/// - Parameters:
///   - url: URL
///   - headers: Request headers
///   - method: HTTP method
///   - body: Request body
///   - handler: Response handler
public func fetch(_ url: URL, headers: [HTTPHeader] = [], method: HTTPMethod = .get, body: Data? = nil, _ handler: @escaping (Response) -> Void) {

    if !isConnectedToNetwork() {
        return handler(Response(url: url, error: NoNetworkConnectionError(), status: -3))
    }

    let h = Dictionary(uniqueKeysWithValues: headers.map { $0.createHeader() })
    var req = URLRequest(url: url, headers: h, method: method.rawValue, body: body)
    req.timeoutInterval = 60

    DispatchQueue.global(qos: .userInitiated).async {
        let s = DispatchSemaphore(value: 0)
        var response: Response? = nil

        for _ in 0..<3 {
            URLSession.shared.dataTask(with: req) { (data, res, error) in
                if let err = error {
                    response = Response(url: url, error: err)
                } else {
                    response = Response(
                        url: url,
                        data: data,
                        response: res as! HTTPURLResponse)
                }
                s.signal()
            }.resume()
            s.wait()
            if response!.ok {
                return handler(response!)
            }
        }
        
        return handler(response!)
    }
}

/// Fetch web resource asynchronous
/// - Parameters:
///   - url: URL
///   - headers: Request headers
///   - method: HTTP method
///   - body: Request body
///   - handler: Response handler
public func fetch(_ url: String, headers: [HTTPHeader] = [], method: HTTPMethod = .get, body: Data? = nil, _ handler: @escaping (Response) -> Void) {
    return fetch(URL(string: url)!, headers: headers, method: method, body: body, handler)
}


/// Fetch web resource synchronous
/// - Parameters:
///   - url: URL
///   - headers: Request headerså
///   - method: HTTP method
///   - body: Request body
/// - Returns: Server response
public func fetch(_ url: URL, headers: [HTTPHeader] = [], method: HTTPMethod = .get, body: Data? = nil) -> Response {
    let s = DispatchSemaphore(value: 0)
    var response: Response? = nil
    fetch(url, headers: headers, method: method, body: body) { res in
        response = res
        s.signal()
    }
    s.wait()
    return response!
}

/// Fetch web resource synchronous
/// - Parameters:
///   - url: URL
///   - headers: Request headers
///   - method: HTTP method
///   - body: Request body
/// - Returns: Server response
public func fetch(_ url: String, headers: [HTTPHeader] = [], method: HTTPMethod = .get, body: Data? = nil) -> Response {
    return fetch(URL(string: url)!, headers: headers, method: method, body: body)
}

