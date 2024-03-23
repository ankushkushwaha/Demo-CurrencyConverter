//
//  ExchangeRateService.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

protocol ExchangeServiceProtocol: NetworkServiceProtocol {
    func fetchExchangeRates(_for currencySymbol: String) async -> Result<ExchangeRateResponse, Error>
}

struct ExchangeRateService: ExchangeServiceProtocol {
    
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
            let (data, _) = try await get(url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(ExchangeRateResponse.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
}
