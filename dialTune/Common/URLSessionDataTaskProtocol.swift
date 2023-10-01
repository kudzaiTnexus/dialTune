//
//  URLSessionDataTask.swift
//  dialTune
//
//  Created by KudzaisheMhou on 01/10/2023.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionDataTaskProtocol {}
