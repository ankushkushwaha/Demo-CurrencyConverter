//
//  DataStoreService.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

protocol DataStoreServiceProtocol {
    func setExchageRatesForCurrencySymbol(_ baseCurrencySymbol: String,
                                          data: ExchangeRateResponse) throws
    func getExchageRatesForCurrencySymbol(_ baseCurrencySymbol: String) -> ExchangeRateResponse?
}

struct DataStoreService: DataStoreServiceProtocol {
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func setExchageRatesForCurrencySymbol(_ baseCurrencySymbol: String,
                                          data: ExchangeRateResponse) throws {
        let jsonData = try JSONEncoder().encode(data)
        defaults.set(jsonData, forKey: baseCurrencySymbol)
    }
    
    func getExchageRatesForCurrencySymbol(_ baseCurrencySymbol: String) -> ExchangeRateResponse? {
        
        guard let exchangeRateData = defaults.value(forKey: baseCurrencySymbol) as? Data else {
            return nil
        }
        
        do {
            let ExchangeRateResponse = try JSONDecoder().decode(ExchangeRateResponse.self, from: exchangeRateData)
            return ExchangeRateResponse
            
        } catch {
            return nil
        }
    }
}
