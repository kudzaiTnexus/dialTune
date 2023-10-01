//
//  NetworkClientTests.swift
//  dialTuneTests
//
//  Created by KudzaisheMhou on 01/10/2023.
//

import XCTest
@testable import dialTune

class NetworkClientImplementationTests: XCTestCase {
    
    func testSuccessfulResponse() async {
        let mockSession = MockURLSession()
        mockSession.mockData = "{\"key\":\"value\"}".data(using: .utf8) // Mock JSON data
        let client = NetworkClientImplementation(session: mockSession)
        
        do {
            let result: [String: String] = try await client.get(URL(string: "https://test.com")!)
            XCTAssertEqual(result["key"], "value")
        } catch {
            XCTFail("Expected successful decoding, but received error: \(error)")
        }
    }
    
    func testDecodingError() async {
        let mockSession = MockURLSession()
        mockSession.mockData = "Invalid JSON".data(using: .utf8) // Invalid JSON data
        let client = NetworkClientImplementation(session: mockSession)
        
        do {
            let _: [String: String] = try await client.get(URL(string: "https://test.com")!)
            XCTFail("Expected decoding error, but decoding was successful")
        } catch let NetworkError.decodingError(decodingError) {
            XCTAssertTrue(true, "Expected decoding error: \(decodingError)")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testInvalidResponse() async {
        let mockSession = MockURLSession()
        mockSession.mockStatusCode = 404 // Not Found
        mockSession.mockData = Data()  // <-- Set some mock data, even if it's empty
        let client = NetworkClientImplementation(session: mockSession)
        
        do {
            let _: [String: String] = try await client.get(URL(string: "https://test.com")!)
            XCTFail("Expected invalid response error")
        } catch NetworkError.invalidResponse {
            XCTAssertTrue(true, "Expected invalid response error")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testUnexpectedError() async {
        let mockSession = MockURLSession()
        mockSession.mockError = NetworkError.unknown
        let client = NetworkClientImplementation(session: mockSession)
        
        do {
            let _: [String: String] = try await client.get(URL(string: "https://test.com")!)
            XCTFail("Expected unexpected error")
        } catch NetworkError.unknown {
            XCTAssertTrue(true, "Expected unexpected error")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testEmptyData() async {
        let mockSession = MockURLSession()
        mockSession.mockData = Data() // Empty data
        let client = NetworkClientImplementation(session: mockSession)
        
        do {
            let _: [String: String] = try await client.get(URL(string: "https://test.com")!)
            XCTFail("Expected decoding error due to empty data")
        } catch NetworkError.decodingError {
            XCTAssertTrue(true, "Expected decoding error due to empty data")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testMismatchedDataModel() async {
        let mockSession = MockURLSession()
        mockSession.mockData = "{\"id\":12345}".data(using: .utf8) // Different JSON structure
        let client = NetworkClientImplementation(session: mockSession)
        
        do {
            let _: [String: String] = try await client.get(URL(string: "https://test.com")!)
            XCTFail("Expected decoding error due to mismatched data model")
        } catch NetworkError.decodingError {
            XCTAssertTrue(true, "Expected decoding error due to mismatched data model")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}
