//
//  APIEndpoint.swift
//  Networking
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

/// A protocol representing the essential properties and methods for defining an API endpoint.
public protocol APIEndPoint {
    /// The base URL of the API endpoint.
    var baseURL: URL { get }

    /// The specific path of the API endpoint, appended to the base URL.
    var path: String { get }

    /// The HTTP method to be used for the API request (e.g., "GET", "POST").
    var method: HTTPMethod { get }

    /// The headers to be included in the API request.
    var headers: [String: String]? { get }

    /// The parameters to be included in the body of the API request.
    var parameters: [String: Any]? { get }

    /// A computed property that generates a URLRequest based on the other properties.
    var urlRequest: URLRequest { get }
}

/// An extension of the APIEndpoint protocol to provide a default implementation for generating a URLRequest.
public extension APIEndPoint {
    var urlRequest: URLRequest {
        // Create a URL by appending the path to the base URL.
        var request: URLRequest

        // Handle GET method differently to include parameters in the URL.
        if method == .get, let params = parameters {
            var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            let finalURL = urlComponents?.url ?? baseURL.appendingPathComponent(path)
            request = URLRequest(url: finalURL)
        } else {
            request = URLRequest(url: baseURL.appendingPathComponent(path))
            // If parameters are provided for non-GET methods, serialize them to JSON and set them as the HTTP body.
            if let params = parameters {
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        }

        // Set the HTTP method for the request.
        request.httpMethod = method.rawValue

        // Add the headers to the request.
        request.allHTTPHeaderFields = headers

        // Return the configured URLRequest.
        return request
    }
}

/// Example implementation of the APIEndpoint protocol
/// ```swift
/// struct ExampleEndpoint: APIEndpoint {
///     var baseURL: URL {
///         return URL(string: "https://api.example.com")!
///     }
///
///     var path: String {
///         return "/example"
///     }
///
///     var method: String {
///         return "POST"
///     }
///
///     var headers: [String : String]? {
///         return ["Content-Type": "application/json"]
///     }
///
