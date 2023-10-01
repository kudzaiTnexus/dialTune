//
//  MockURLSession.swift
//  dialTuneTests
//
//  Created by KudzaisheMhou on 01/10/2023.
//

import Foundation
@testable import dialTune

class MockURLSession: URLSessionDataTaskProtocol {
    var mockData: Data?
    var mockError: Error?
    var mockStatusCode: Int = 200
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let mockError = mockError {
            throw mockError
        }
        
        let response = HTTPURLResponse(url: url, statusCode: mockStatusCode, httpVersion: nil, headerFields: nil)!
        if let mockData = mockData {
            return (mockData, response)
        } else {
            throw NetworkError.unknown
        }
    }
}

