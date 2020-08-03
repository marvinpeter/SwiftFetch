//
//  HTTPMethod.swift
//  
//
//  Created by Marvin Peter on 8/3/20.
//

import Foundation

public enum HTTPMethod: String {
    
    /// The HTTP GET method requests a representation of the specified resource. Requests using GET should only retrieve data.
    case get = "GET"
    
    /// The HTTP POST method sends data to the server. The type of the body of the request is indicated by the Content-Type header.
    case post = "POST"
    
    /// The HTTP PUT request method creates a new resource or replaces a representation of the target resource with the request payload.
    case put = "PUT"
    
    /// The HTTP PATCH request method applies partial modifications to a resource.
    case patch = "PATCH"
    
    /// The HTTP DELETE request method deletes the specified resource.
    case delete = "DELETE"
    
    /// The HTTP OPTIONS method is used to describe the communication options for the target resource.
    case options = "OPTIONS"
    
    /// The HTTP HEAD method requests the headers that are returned if the specified resource would be requested with an HTTP GET method.
    case head = "HEAD"
}
