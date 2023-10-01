//
//  NetworkClient.swift
//  dialTune
//
//  Created by KudzaisheMhou on 01/10/2023.
//

import Foundation

protocol NetworkClient {
    func get<T: Decodable>(_ url: URL) async throws -> T
}

class NetworkClientImplementation: NetworkClient {
    
    let session: URLSessionDataTaskProtocol
    
    init(session: URLSessionDataTaskProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get<T: Decodable>(_ url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
