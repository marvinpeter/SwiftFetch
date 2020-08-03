//
//  HTTPContentType.swift
//  
//
//  Created by Marvin Peter on 8/3/20.
//

import Foundation

/// This enum contains the most common types for the "Accept" and "Content-Type" headers.
public enum HTTPContentType {
    case aac
    case bin
    case bmp, gif, jpg, png, tif, webp
    case bz, bz2, gz, zip
    case css, html, javascript, xhtml
    case csv, json, plain, xml
    case ico
    case mp3, oga, opus, weba
    case ogv, ts, webm
    case pdf
    case ttf, woff, woff2
    
    /// Define a custom application type (e.g. .application("x") => "application/x")
    case application(String)
    
    /// Define a custom audio type (e.g. .audio("x") => "audio/x")
    case audio(String)
    
    /// Define a custom image type (e.g. .image("x") => "image/x")
    case image(String)
    
    /// Define a custom text type (e.g. .text("x") => "text/x")
    case text(String)
    
    /// Define a custom video type (e.g. .video("x") => "video/x")
    case video(String)
    
    /// Define a custom  type (e.g. .custom("x") => "x")
    case custom(String)
    
    var typeString: String {
        switch self {
        case .aac: return "audio/aac"
        case .bin: return "application/octet-stream"
        case .bmp: return "image/bmp"
        case .bz: return "application/x-bzip"
        case .bz2: return "application/x-bzip2"
        case .css: return "text/css"
        case .csv: return "text/csv"
        case .gz: return "application/gzip"
        case .gif: return "image/gif"
        case .html: return "text/html"
        case .ico: return "image/vnd.microsoft.icon"
        case .jpg: return "image/jpeg"
        case .javascript: return "text/javascript"
        case .json: return "application/json"
        case .mp3: return "audio/mpeg"
        case .oga: return "audio/ogg"
        case .ogv: return "video/ogg"
        case .opus: return "audio/opus"
        case .png: return "image/png"
        case .pdf: return "application/pdf"
        case .tif: return "image/tiff"
        case .ts: return "video/mp2t"
        case .ttf: return "font/ttf"
        case .plain: return "text/plain"
        case .weba: return "audio/webm"
        case .webm: return "video/webm"
        case .webp: return "image/webp"
        case .woff: return "font/woff"
        case .woff2: return "font/woff2"
        case .xhtml: return "application/xhtml+xml"
        case .xml: return "application/xml"
        case .zip: return "application/zip"
        case .application(let type): return "application/\(type)"
        case .audio(let type): return "audio/\(type)"
        case .image(let type): return "image/\(type)"
        case .text(let type): return "text/\(type)"
        case .video(let type): return "video/\(type)"
        case .custom(let type): return type
        }
    }
}
