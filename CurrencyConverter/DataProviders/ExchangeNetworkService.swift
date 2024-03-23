//
//  ExchangeRateService.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

protocol ExchangeServiceProtocol {
    func fetchExchangeRates(_for currencySymbol: String) async -> Result<ExchangeRateResponse, Error>
}

class ExchangeRateService: ExchangeServiceProtocol {
    
    func fetchExchangeRates(_for currencySymbol: String) async -> Result<ExchangeRateResponse, Error> {
        
        let url = "\(Endpoints.exchangeRates)&base=\(currencySymbol)"
        
        return await URLSession.shared.fetchData(url: url)
    }
}
