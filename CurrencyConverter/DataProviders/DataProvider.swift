//
//  DataProvider.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

protocol DataProviderProtocol {
    func getExchangeRateData(_ currencySymbol: String) async -> ExchangeRateResponse?
}


struct DataProvider: DataProviderProtocol {
    
    private let dataStore: DataStoreServiceProtocol
    private let exchangeService: ExchangeServiceProtocol
    
    // Dependency Injection to mock data -> MockExchangeService()
    init(dataStore: DataStoreServiceProtocol = DataStoreService(),
         exchangeService: ExchangeServiceProtocol = ExchangeRateService()) {
        self.dataStore = dataStore
        self.exchangeService = exchangeService
    }
    
    func getExchangeRateData(_ currencySymbol: String = "USD") async -> ExchangeRateResponse? {
        
        let localData = dataStore.getExchageRatesForCurrencySymbol(currencySymbol)
        
        // Check validity if data fetched within 30 minutes
        if let localData = localData,
           DataValidator().isDataValid(timestamp: localData.timestamp) {
            return localData
        }
        
        // Fetch from network API
        if let data = await fetchData(currencySymbol) {
            return data
        }
        
        // In case API faliure, show old data in UI
        return localData
    }
    
    private func fetchData(_ currencySymbol: String) async -> ExchangeRateResponse? {
        let result: Result<ExchangeRateResponse, Error> = await exchangeService.fetchExchangeRates(_for: currencySymbol)
        
        switch result {
        case .success(let data):
            do {
                try dataStore.setExchageRatesForCurrencySymbol(currencySymbol,
                                                               data: data)
            } catch {
                print(error)
            }
            return data
        case .failure(let error):
            print(error)
            return nil
        }
    }
}
