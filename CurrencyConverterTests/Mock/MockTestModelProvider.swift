//
//  MockTestModelProvider.swift
//  CurrencyConverterTests
//
//  Created by Ankush Kushwaha on 23/03/24.
//

import Foundation
@testable import CurrencyConverter

struct MockTestModelProvider {
    var data: Data?
    
    init(_ jsonData: Data? = nil) {
        if let jsonData = jsonData {
            data = jsonData
        } else {
            data = MockTestJsonData().getJsonData()
        }
    }
    
    func getExchangeRates() throws -> ExchangeRateResponse? {
        guard let jsonData = data else {
            return nil
        }
        do {
            let mockData = try JSONDecoder().decode(ExchangeRateResponse.self, from: jsonData) as ExchangeRateResponse
            return mockData
        } catch {
            print(error)
            return nil
        }
    }
}
