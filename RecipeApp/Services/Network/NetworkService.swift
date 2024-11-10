//
//  NetworkService.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/8/24.
//


import Foundation

protocol NetworkingAPI {
    func request<T: Decodable>(_ absoluteURL: String) async throws -> T
}

final class NetworkingLayer: NetworkingAPI {
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func request<T: Decodable>(_ absoluteURL: String) async throws -> T {
        guard let url = URL(string: absoluteURL) else {
            throw NetworkingError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            // Check for HTTP response status
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkingError.invalidStatusCode(statusCode: httpResponse.statusCode)
                }
            }
            
            // Attempt to decode the response
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkingError.failedToDecode(description: error.localizedDescription)
            }
            
        } catch let error as NetworkingError {
            // Re-throw known NetworkingError for clarity
            throw error
        } catch {
            throw NetworkingError.requestFailed(description: error.localizedDescription)
        }
    }
}

// MARK: - Networking Errors
extension NetworkingLayer {
    enum NetworkingError: Error {
        case requestFailed(description: String)
        case invalidURL
        case invalidData
        case invalidStatusCode(statusCode: Int)
        case failedToDecode(description: String)
        case jsonParsingFailure
        case failedSerialization
        case noInternet
        
        var customDescription: String {
            switch self {
            case let .requestFailed(description): return "Request Failed: \(description)"
            case .invalidURL: return "Invalid URL"
            case .invalidData: return "Invalid Data"
            case let .invalidStatusCode(statusCode): return "Status Code: \(statusCode)"
            case let .failedToDecode(description): return "JSON Decode Failure: \(description)"
            case .jsonParsingFailure: return "JSON Parsing Failure"
            case .failedSerialization: return "Serialization failed."
            case .noInternet: return "No internet connection"
            }
        }
    }
}
