//
//  NetworkServiceError.swift
//  Networking
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

/// Represents errors that may occur when performing network requests.
public enum NetworkServiceError: Error {
    /// Indicates that the response from the server returned a non-successful HTTP status code.
    ///
    /// - Parameter statusCode: The HTTP status code received.
    case invalidStatusCode(Int)

    /// Indicates a failure to decode the response data into the expected model.
    ///
    /// - Parameter error: The underlying decoding error.
    case decodingError(Error)

    /// Represents an error response from the backend with associated raw data and status code.
    ///
    /// - Parameters:
    ///   - data: The raw response body returned by the backend.
    ///   - statusCode: The HTTP status code received from the backend.
    case backendError(Data, Int)

    /// Indicates an unexpected or unclassified error that occurred during the request lifecycle.
    ///
    /// - Parameter error: The underlying unknown error.
    case unknown(Error)
}
