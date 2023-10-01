//
//  NetworkError.swift
//  dialTune
//
//  Created by KudzaisheMhou on 01/10/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    case unknown
}
