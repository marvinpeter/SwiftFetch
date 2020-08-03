# SwiftFetch
SwiftFetch is a small library designed to make simple asynchronous and synchronous web requests by wrapping URLSession. It is inspired by JavaScript's fetch command. For more complex use cases I recommend using [Alamofire](https://github.com/Alamofire/Alamofire) instead. <br>
This library has not dependencies and works on macOS, iOS, iPadOS, tvOS and watchOS.

## Examples
### Asynchronous Requests
Since SwiftFetch wraps ```URLSession.shared.dataTask``` requests are made from a background thread making fetch asynchronous by default. For synchronous requests see "Synchronous Requests" below.

### Fetch a JSON Resource
``` swift
struct Ipify: Decodable {
    let ip: String
}

fetch("https://api.ipify.org?format=json") { res in
    guard let ipify = res.json(Ipify.self) else {
        print("On no!, an error occurred.")
        return
    }
    
    print(ipify) // Ipify(ip: "127.0.0.1")
}
```

### POST JSON Data
``` swift
struct Person: Codable {
    let name: String
    let age: Int
}

let person = Person(name: "John Smith", age: 24)
let personData = try! JSONEncoder().encode(person)

fetch("https://postman-echo.com/post", headers: [
        .contentType(.json),
        .userAgent("Custom"),
    .accept(.plain)
], method: .post, body: personData) { res in
    guard let text = res.text else {
        print("On no!, an error occurred.")
        return
    }
    
    print(text)
    /* {
         "args": {},
         "data": {
             "name": "John Smith",
             "age": 24
         },
         "files": {},
         "form": {},
         "headers": {
             "x-forwarded-proto": "https",
             "x-forwarded-port": "443",
             "host": "postman-echo.com",
             "x-amzn-trace-id": "Root=1-5f27bd54-d6ed98d3c7fcb5296a1aae6d",
             "content-length": "30",
             "accept": "text/plain",
             "content-type": "application/json",
             "accept-encoding": "gzip, deflate, br",
             "if-none-match": "W/\"1c7-PQ8OyLFk6ib7BBtCyb9Hgh+zm94\"",
             "user-agent": "Custom",
             "accept-language": "en-us"
         },
         "json": {
             "name": "John Smith",
             "age": 24
         },
         "url": "https://postman-echo.com/post"
     } */
}
```

### Synchronous Requests
Synchronous requests wrap ```URLSession.shared.dataTask``` as well. Therefore, requests are still made from a background thread. The only difference is that synchronous fetch blocks the current thread until the response is available. Do not use synchronous requests in the main UI thread because this will cause the application to freeze until the request is completed.

### Fetch a JSON Resource
``` swift
struct Ipify: Decodable {
    let ip: String
}

let res = fetch("https://api.ipify.org?format=json")
guard let ipify = res.json(Ipify.self) else {
    print("On no!, an error occurred.")
    exit(-1)
}

print(ipify) // Ipify(ip: "127.0.0.1")
```

### POST JSON Data
``` swift
struct Person: Codable {
    let name: String
    let age: Int
}

let person = Person(name: "John Smith", age: 24)
let personData = try! JSONEncoder().encode(person)

let res = fetch("https://postman-echo.com/post", headers: [
        .contentType(.json),
        .userAgent("Custom"),
    .accept(.plain)
], method: .post, body: personData)
guard let text = res.text else {
    print("On no!, an error occurred.")
    exit(-1)
}

print(text)
/* {
    "args": {},
    "data": {
        "name": "John Smith",
        "age": 24
    },
    "files": {},
    "form": {},
    "headers": {
        "x-forwarded-proto": "https",
        "x-forwarded-port": "443",
        "host": "postman-echo.com",
        "x-amzn-trace-id": "Root=1-5f27bd54-d6ed98d3c7fcb5296a1aae6d",
        "content-length": "30",
        "accept": "text/plain",
        "content-type": "application/json",
        "accept-encoding": "gzip, deflate, br",
        "if-none-match": "W/\"1c7-PQ8OyLFk6ib7BBtCyb9Hgh+zm94\"",
        "user-agent": "Custom",
        "accept-language": "en-us"
    },
    "json": {
        "name": "John Smith",
        "age": 24
    },
    "url": "https://postman-echo.com/post"
} */
```

## API Documentation
### Asynchronous Fetch Commands
``` swift
/// Fetch web resource asynchronous
/// - Parameters:
///   - url: URL
///   - headers: Request headers
///   - method: HTTP method
///   - body: Request body
///   - handler: Response handler
func fetch(_ url: URL, headers: [HTTPHeader] = [], method: HTTPMethod = .get, body: Data? = nil, _ handler: @escaping (Response) -> Void)

/// Fetch web resource asynchronous
/// - Parameters:
///   - url: URL
///   - headers: Request headers
///   - method: HTTP method
///   - body: Request body
///   - handler: Response handler
func fetch(_ url: String, headers: [HTTPHeader] = [], method: HTTPMethod = .get, body: Data? = nil, _ handler: @escaping (Response) -> Void)
```

### Synchronous Fetch Commands
``` swift 
/// Fetch web resource synchronous
/// - Parameters:
///   - url: URL
///   - headers: Request headerså
///   - method: HTTP method
///   - body: Request body
/// - Returns: Server response
func fetch(_ url: URL, headers: [HTTPHeader] = [], method: HTTPMethod = .get, body: Data? = nil) -> Response

/// Fetch web resource synchronous
/// - Parameters:
///   - url: URL
///   - headers: Request headers
///   - method: HTTP method
///   - body: Request body
/// - Returns: Server response
func fetch(_ url: String, headers: [HTTPHeader] = [], method: HTTPMethod = .get, body: Data? = nil) -> Response
```

### Response
``` swift
/// Structure representing a server response.
struct Response {
    
    /// Headers associated with the response.
    let headers: [String: String]

    /// The status code of the response.
    let status: Int

    /// The requested URL
    let url: URL

    /// Error information in case the request failed
    let error: Error?

    /// Indicates whether the response was successful (status in the range 200–299) or not.
    let ok: Bool
    
    /// Return all cookies associated with the requested domain
    let cookies: [String: String]

    /// Get the response body
    /// - Returns: Data
    let data: Data?

    /// Decode the response body to text using UTF8
    /// - Returns: Text representation
    let text: String?

    /// Decode the response body to text
    /// - Parameter encoding: Encoding
    /// - Returns: Text representation
    func text(encoding: String.Encoding) -> String?

    /// Parse body into an decodable object
    /// - Parameter type: Target type
    /// - Returns: Parsed object
    func json<T: Decodable>(_ type: T.Type) -> T?
}

```
