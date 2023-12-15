//
//  DataProviderTests.swift
//  CurrencyConverterTests
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation
import XCTest
@testable import CurrencyConverter

class DataProviderTests: XCTestCase {
    
    var sut: DataProvider!
    var userDefaults: UserDefaults!
    var dataStore: DataStoreService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        
        dataStore = DataStoreService(defaults: userDefaults)
        
        sut = DataProvider(dataStore: dataStore,
                           exchangeService: MockExchangeService())
    }
    
    override func tearDownWithError() throws {
        userDefaults.removeSuite(named: #file)
        userDefaults = nil
        dataStore = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGetExchangeRateDataSuccess() async {
        let mockService = MockExchangeService()
        mockService.shouldSucceed = true
        
        let dataProvider = DataProvider(dataStore: dataStore,
                                        exchangeService: MockExchangeService())
        
        let result = await dataProvider.getExchangeRateData()
        
        XCTAssertNotNil(result, "Result should not be nil")
        XCTAssertNotNil(result?.base, "Base currency should not be nil")
    }
    
    func testGetExchangeRateDataFaliure() async {
        
        let mockService = MockExchangeService()
        mockService.shouldSucceed = false
        
        let dataProvider = DataProvider(dataStore: dataStore,
                                        exchangeService: mockService)
        
        let result = await dataProvider.getExchangeRateData()
        
        XCTAssertNil(result, "Result should be nil")
    }
}

extension DataProviderTests {
    class MockExchangeService: ExchangeServiceProtocol {
        
        var shouldSucceed = true
        
        enum MockServiceError: Error {
            case dataNotFound
            case mockDataNotAvailable
        }
        
        func fetchExchangeRates(_for currencySymbol: String) async -> Result<ExchangeRateResponse, Error> {
            
            if shouldSucceed {
                do {
                    guard let mockData = try MockDataService().getMockAPIResponse() else {
                        return .failure(MockServiceError.mockDataNotAvailable)
                    }
                    return .success(mockData)
                    
                } catch {
                    return .failure(MockServiceError.mockDataNotAvailable)
                }
            }
            return .failure(MockServiceError.dataNotFound)
        }
    }
}
