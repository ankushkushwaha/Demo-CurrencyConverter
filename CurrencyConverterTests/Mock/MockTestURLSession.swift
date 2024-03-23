//
//  MockTestURLSession.swift
//  CurrencyConverterTests
//
//  Created by Ankush Kushwaha on 23/03/24.
//

import Foundation
@testable import CurrencyConverter

struct MockTestURLSession: URLSessionProtocol {
    
    var error: Error? = nil
    
    func data(_ url: URL) async throws -> (Data, URLResponse) {
        
        if let error = error {
            throw error
        }
        return try await mockFetchData(url: url)
    }
    
    private func mockFetchData(url: URL) async throws -> (Data, URLResponse) {
        
        let fakeSuccessResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
        
        let mockData = MockTestJsonData().getJsonData()
        
        guard let mockData = mockData,
              let response = fakeSuccessResponse else {
            throw MockError.dataError
        }
        return (mockData, response)
    }
}


enum MockError: Error {
    case dataError
    var errorMessage: String {
        switch self {
        case .dataError:
            return String(localized: "Could not fetch data from mock json file.")
        }
    }
}
