//
//  HTTPAuthorization.swift
//  
//
//  Created by Marvin Peter on 8/3/20.
//

import Foundation


/// This enum contains the possible types for the "Authorization" header.
public enum HTTPAuthorization {
    /// base64-encoded credentials (RFC 7617)
    case basic
    
    /// Token based access to OAuth 2.0-protected resources (RFC 6750)
    case bearer
    
    /// RFC 7616
    case digest
    
    /// Define a custom authorization type
    case custom(String)
    
    var typeString: String {
        switch self {
        case .basic: return "Basic"
        case .bearer: return "Bearer"
        case .digest: return "Digest"
        case .custom(let type): return type
        }
    }
}
