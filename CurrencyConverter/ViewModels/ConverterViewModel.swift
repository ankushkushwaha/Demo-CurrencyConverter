//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

class ConverterViewModel: ObservableObject {
    
    @Published var currencyListModels: [CurrencyRateModel] = []
    @Published var originalCurrencyModels: [CurrencyRateModel] = []
    @Published var error: DataError?
    @Published var isLoading = true
    @Published var amount = "1.00"
    @Published var selectedBaseCurrency: CurrencyRateModel? {
        didSet {
            calculateConversionRates()
        }
    }
    private let dataProvider: DataProviderProtocol
    
    // dependency injection for unit test
    init(dataProvider: DataProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
    }
    
    @MainActor
    func fetchAndShowCurrencies(_ currencySymbol: String? = nil) async  {
        isLoading = true
        
        if let data = await dataProvider.getExchangeRateData("USD") {
            // print(data)
            setupData(data)
            
            error = nil
        } else {
            error = DataError.networkError
        }
        isLoading = false
    }
    
    func calculateConversionRates() {
        
        // if invalid input, set default amount to 1.00
        if amount.decimalValue == nil {
            amount = "1.00"
        }
        
        guard let factorNumber = amount.decimalValue,
              let newBaseCurrency = selectedBaseCurrency else {
                  return
              }
        
        currencyListModels = originalCurrencyModels.map { model in
            let newRate = model.rate / newBaseCurrency.rate
            let symbol = model.currencySymbol
            let model = CurrencyRateModel(currencySymbol: symbol,
                                          rate: newRate,
                                          convertedRate: newRate * factorNumber)
            return model
        }
    }
    
    private func setupData(_ data: ExchangeRateResponse) {
        
        originalCurrencyModels = data.rates.map { key, value in
            return CurrencyRateModel(currencySymbol: key, rate: value, convertedRate: nil)
        }
        .sorted{$0.currencySymbol < $1.currencySymbol}
        
        // set base currency USD
        selectedBaseCurrency = originalCurrencyModels.filter({ item in
            item.currencySymbol == "USD"
        }).first
    }
}
