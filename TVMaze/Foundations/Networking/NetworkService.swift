//
//  NetworkService.swift
//  Networking
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation
import os

/// A shared service responsible for executing network requests
/// and decoding the responses into specified models.
///
/// It supports token injection, retries, and detailed logging during development.
public struct NetworkService {
    /// The shared singleton instance of NetworkService.
    public static let shared = NetworkService()

    private let keychainManager: KeychainStorable = KeychainWrapper.shared
    private let logger = Logger(subsystem: "ar.com.wellspend.networking", category: "NetworkService")

    /// Private initializer to enforce singleton pattern.
    private init() {}

    /**
     Sends an HTTP request to the specified API endpoint and decodes the response into the specified type.
     The request retries up to a maximum of `maxRetries` times if it fails.

     This function allows for secure API requests by including a Bearer token in the `Authorization` header if the request is marked as secure.

     - Parameters:
       - endpoint: The `APIEndPoint` that defines the request details, such as the URL, HTTP method, headers, and parameters.
       - type: The type to which the response data should be decoded. This must conform to the `Decodable` protocol.
       - retryCount: The number of retry attempts made so far (defaults to 0).
       - maxRetries: The maximum number of retry attempts allowed (defaults to 2).

     - Returns: An instance of the specified type `T` that represents the decoded response, or throws an error.

     - Throws:
       - `URLError(.badServerResponse)` if the response is not in the 200-299 range or if the maximum retry attempts have been reached.
       - `URLError(.cannotDecodeContentData)` if the response data is empty and cannot be decoded.
       - `NetworkServiceError` for known decoding, backend, or unknown issues.

     - Example Usage:
     ```swift
     let endpoint = YourAPIEndpoint()
     do {
         let response: YourResponseType = try await networkService.request(endpoint, as: YourResponseType.self)
         print("Request succeeded with response: \(response)")
     } catch {
         print("Request failed with error: \(error)")
     }
     ```
     */
    public func request<T: Decodable>(
        _ endpoint: APIEndPoint,
        as type: T.Type,
        retryCount: Int = 0,
        maxRetries: Int = 2
    ) async throws(NetworkServiceError) -> T {
        var urlRequest = endpoint.urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 130
            let session = URLSession(configuration: config)
            let (data, response) = try await session.data(for: urlRequest)

            // swiftlint: disable force_https
            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("❌ Invalid response received (no HTTPURLResponse)")
                throw NetworkServiceError.unknown(URLError(.badServerResponse))
            }
            // swiftlint: enable force_https

            guard (200...299).contains(httpResponse.statusCode) else {
                logger.error("❌ Backend error - status code: \(httpResponse.statusCode)")
                throw NetworkServiceError.backendError(data, httpResponse.statusCode)
            }

            if data.isEmpty {
                if let emptyResponse = APIEmptyResponse() as? T {
                    return emptyResponse
                } else {
                    throw URLError(.cannotDecodeContentData)
                }
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch let decodingError as DecodingError {
            logger.error("❌ Decoding error: \(String(describing: decodingError))")
            throw NetworkServiceError.decodingError(decodingError)
        } catch let networkError as NetworkServiceError {
            logger.error("❌ NetworkServiceError: \(String(describing: networkError))")
            throw networkError
        } catch {
            logger.error("❌ Unknown error: \(String(describing: error))")
            throw NetworkServiceError.unknown(error)
        }
    }
}
