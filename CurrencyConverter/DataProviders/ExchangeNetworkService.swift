//
//  ExchangeRateService.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

struct ExchangeRateService: ExchangeRateServiceProtocol {
    
    let urlSession: URLSessionProtocol
    
    // Dependency Injection to mock urlSession for testing
    init(_ urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchExchangeRates(_for currencySymbol: String) async -> Result<ExchangeRateResponse, Error> {
        
        guard let url = URL(string: "\(Endpoints.exchangeRates)&base=\(currencySymbol)") else {
            return .failure(NetworkingError.invalidURL)
        }
        
        do {
            let (data, _) = try await urlSession.fetchData(url: url)
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ExchangeRateResponse.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
}


protocol ExchangeRateServiceProtocol {
    func fetchExchangeRates(_for currencySymbol: String) async -> Result<ExchangeRateResponse, Error>
}

protocol URLSessionProtocol {
    func fetchData(url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func fetchData(url: URL) async throws -> (Data, URLResponse) {
        try await self.data(from: url)
    }
}
