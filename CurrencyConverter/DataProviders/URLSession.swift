//
//  URLSession.swift
//  CurrencyConverter
//
//  Created by Ankush Kushwaha on 23/03/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(_ url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    
    func data(_ url: URL) async throws -> (Data, URLResponse) {
        let (data, response) = try await data(from: url)
        return (data, response)
    }
}

