//
//  HTTPHeader.swift
//  
//
//  Created by Marvin Peter on 8/3/20.
//

import Foundation

/// This enum define a single HTTP header and contains definitions for the most common headers.
public enum HTTPHeader {
    
    /// The Accept request HTTP header advertises which content types, expressed as MIME types, the client is able to understand.
    case accept(HTTPContentType)
    
    /// The Accept-Encoding request HTTP header advertises which content encoding, usually a compression algorithm, the client is able to understand
    case acceptEncoding(HTTPContentEncoding)
    
    /// The Accept-Language request HTTP header advertises which languages the client is able to understand, and which locale variant is preferred.
    case acceptLanguage(String)
    
    /// The Accept-Charset request HTTP header advertises which character encodings the client understands (e.g. utf-8)
    case acceptCharset(String)
    
    /// The HTTP Authorization request header contains the credentials to authenticate a user agent with a server.
    case authorization(HTTPAuthorization, String)
    
    /// The Cookie HTTP request header contains stored HTTP cookies.
    case cookie(String)
    
    /// The Content-Encoding entity header is used to compress the media-type.
    case contentEncoding(HTTPContentEncoding)
    
    /// The Content-Language entity header is used to describe the language(s) intended for the audience, so that it allows a user to differentiate according to the users' own preferred language.
    case contentLanguage(String)
    
    /// The Content-Length entity header indicates the size of the entity-body, in bytes, sent to the recipient.
    case contentLength(Int64)
    
    /// The Content-Type entity header is used to indicate the media type of the resource.
    case contentType(HTTPContentType)
    
    /// The Referer request header contains the address of the previous web page from which a link to the currently requested page was followed.
    case referer(String)
    
    /// The User-Agent request header is a characteristic string that lets servers and network peers identify the application, operating system, vendor, and/or version of the requesting user agent.
    case userAgent(String)
    
    /// Define a custom header by providing the header name and value
    case custom(String, String)

    
    func createHeader() -> (String, String) {
        switch self {
        case .authorization(let type, let value):
            return ("Authorization", "\(type.typeString) \(value)")
        case .accept(let value):
            return ("Accept", value.typeString)
        case .acceptEncoding(let value):
            return ("Accept-Encoding", value.typeString)
        case .acceptLanguage(let value):
            return ("Accept-Language", value)
        case .acceptCharset(let value):
            return ("Accept-Charset", value)
        case .cookie(let value):
            return ("Cookie", value)
        case .contentLength(let value):
            return ("contentLength", "\(value)")
        case .contentType(let value):
            return ("Content-Type", value.typeString)
        case .contentEncoding(let value):
            return ("Content-Encoding", value.typeString)
        case .contentLanguage(let value):
            return ("Content-Language", value)
        case .referer(let value):
            return ("Referer", value)
        case .userAgent(let value):
            return ("User-Agent", value)
        case .custom(let header, let value):
            return (header, value)
        }
    }
}
