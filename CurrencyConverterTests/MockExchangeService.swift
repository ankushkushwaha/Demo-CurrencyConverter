//
//  MockExchangeService.swift
//  CurrencyConverterTests
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

class MockExchangeService: ExchangeServiceProtocol {
    
    enum MockServiceError: Error {
        case dataNotFound
    }
    
    func fetchExchangeRates(_for currencySymbol: String) async -> Result<ExchangeRateResponse, Error> {
        
        do {
            guard let mockResponse = try MockDataService().getMockAPIResponse() else {
                return .failure(MockServiceError.dataNotFound)
            }
            return .success(mockResponse)
        } catch {
            return .failure(error)
        }
    }
}

struct MockDataService {
    
    func getMockJsonData() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "MockExchangeRatesData", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                  return nil
              }
        return data
    }
    
    func getMockAPIResponse() throws -> ExchangeRateResponse? {
        guard let jsonData = try getMockJsonData() else {
            return nil
        }
        let mockData = try JSONDecoder().decode(ExchangeRateResponse.self, from: jsonData) as ExchangeRateResponse
        return mockData
    }
}
