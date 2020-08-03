//
//  HTTPContentEncoding.swift
//  
//
//  Created by Marvin Peter on 8/3/20.
//

import Foundation


/// This enum contains the possible types for the "Content-Encoding" header.
public enum HTTPContentEncoding {
    
    /// A format using the Lempel-Ziv coding (LZ77), with a 32-bit CRC. This is the original format of the UNIX gzip program.
    case gzip
    
    /// Using the zlib structure (RFC 1950) with the deflate compression algorithm (RFC 1951).
    case deflate
    
    /// No compression or modification
    case identity
    
    /// A format using the Brotli algorithm.
    case br
    
    /// Except any encoding (*)
    case any
    
    /// Provide a custom encoding type e.g. "deflate, gzip;q=1.0, *;q=0.5"
    case custom(String)
    
    
    var typeString: String{
        switch self {
        case .gzip: return "gzip"
        case .deflate: return "deflate"
        case .identity: return "identity"
        case .br: return "br"
        case .any: return "*"
        case .custom(let type): return type
        }
    }
}
