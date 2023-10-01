//
//  MockNetworkClient.swift
//  dialTuneTests
//
//  Created by KudzaisheMhou on 01/10/2023.
//

import Foundation
@testable import dialTune

class MockNetworkClient: NetworkClient {
    
    // Properties to simulate mock responses or errors
    var mockData: Data?
    var mockError: Error?
    var mockStatusCode: Int = 200
    
    func get<T: Decodable>(_ url: URL) async throws -> T {
        if let mockError = mockError {
            throw mockError
        }
        
        guard mockStatusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        if let mockData = mockData {
            do {
                let decoded = try JSONDecoder().decode(T.self, from: mockData)
                return decoded
            } catch {
                throw NetworkError.decodingError(error)
            }
        } else {
            throw NetworkError.unknown
        }
    }
}
