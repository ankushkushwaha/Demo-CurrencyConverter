//
//  ConverterViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by ankush kushwaha on 09/12/23.
//

import XCTest

import XCTest
@testable import CurrencyConverter

class ConverterViewModelTests: XCTestCase {
    
    func testFetchAndShowCurrenciesSuccess() async throws {
        
        guard let data = try MockDataService().getMockAPIResponse() else {
            XCTFail("Could not read data from MockExchangeRatesData.json")
            return
        }
        
        let dataProvider =  MockDataProvider()
        dataProvider.data = data
        
        let sut = ConverterViewModel(dataProvider: dataProvider)
        
        XCTAssertTrue(sut.isLoading, "isLoading should be true")
        
        await sut.fetchAndShowCurrencies()
        
        XCTAssertFalse(sut.isLoading, "isLoading should be false")
        XCTAssertNil(sut.error, "error should be nil")
        XCTAssertFalse(sut.currencyListModels.isEmpty, "currencyListModels should not be empty")
        XCTAssertFalse(sut.originalCurrencyModels.isEmpty, "originalCurrencyModels should not be empty")
    }
    
    func testFetchAndShowCurrenciesFaliure() async {
        
        let dataProvider =  MockDataProvider()
        dataProvider.data = nil
        
        let sut = ConverterViewModel(dataProvider: dataProvider)
        
        XCTAssertTrue(sut.isLoading, "isLoading should be true")

        await sut.fetchAndShowCurrencies()
        
        XCTAssertFalse(sut.isLoading, "isLoading should be false")
        XCTAssertNotNil(sut.error, "error should not be nil")
        XCTAssertTrue(sut.currencyListModels.isEmpty, "currencyListModels should be empty")
        XCTAssertTrue(sut.originalCurrencyModels.isEmpty, "originalCurrencyModels should be empty")
    }
    
    func testCalculateConversionRates() {
        
        let dataProvider =  MockDataProvider()
        dataProvider.data = nil
        
        let sut = ConverterViewModel(dataProvider: dataProvider)
        
        sut.originalCurrencyModels = [
            CurrencyRateModel(currencySymbol: "USD", rate: 1.0, convertedRate: nil),
            CurrencyRateModel(currencySymbol: "EUR", rate: 0.85, convertedRate: nil),
        ]
        
        sut.selectedBaseCurrency = sut.originalCurrencyModels.first
        
        sut.amount = "2.00"
        sut.calculateConversionRates()
        
        XCTAssertFalse(sut.currencyListModels.isEmpty, "currencyListModels should not be empty")
        
        let factorNumber = sut.amount.decimalValue
        XCTAssertNotNil(factorNumber)
        
        for model in sut.currencyListModels {
            XCTAssertNotNil(model.convertedRate, "convertedRate should not be nil")
            
            XCTAssertEqual(model.rate * factorNumber!, model.convertedRate!)
        }
    }
}

// Mock API service for testing
class MockDataProvider: DataProviderProtocol {
    var data: ExchangeRateResponse?
    
    func getExchangeRateData(_ currencySymbol: String) async -> ExchangeRateResponse? {
        return data
    }
}
