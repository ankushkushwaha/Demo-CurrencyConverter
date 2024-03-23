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
        
        let mockService = ExchangeRateService(MockTestURLSession())
        sut = DataProvider(dataStore: dataStore,
                           exchangeService: mockService)
    }
    
    override func tearDownWithError() throws {
        userDefaults.removeSuite(named: #file)
        userDefaults = nil
        dataStore = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGetExchangeRateDataSuccess() async {
        let dataProvider = DataProvider(dataStore: dataStore,
                                        exchangeService: MockExchangeService())
        
        let result = await dataProvider.getExchangeRateData()
        
        XCTAssertNotNil(result, "Result should not be nil")
        XCTAssertNotNil(result?.base, "Base currency should not be nil")
    }
    
    func testGetExchangeRateDataFaliure() async {
        
        var mockService = MockExchangeService()
        mockService.error = MockExchangeService.Errors.mockDataNotAvailable
        
        let dataProvider = DataProvider(dataStore: dataStore,
                                        exchangeService: mockService)
        
        let result = await dataProvider.getExchangeRateData()
        
        XCTAssertNil(result, "Result should be nil")
    }
}

extension DataProviderTests {
    
    struct MockExchangeService: ExchangeServiceProtocol {
        
        var urlSession: URLSessionProtocol = MockURLSessionPlaceholder()
        
        var error: Error?
        
        enum Errors: Error {
            case mockDataNotAvailable
        }
        
        func fetchExchangeRates(_for currencySymbol: String) async -> Result<ExchangeRateResponse, Error> {
            
            if let error = error {
                return .failure(error)
            }
            do {
                guard let mockData = try MockTestModelProvider().getExchangeRates() else {
                    return .failure(Errors.mockDataNotAvailable)
                }
                return .success(mockData)
                
            } catch {
                return .failure(Errors.mockDataNotAvailable)
            }
        }
    }
    
    struct MockURLSessionPlaceholder: URLSessionProtocol {
        func data(_ url: URL) async throws -> (Data, URLResponse) {
            fatalError("MockURLSessionPlaceHolder method should not be called")
        }
    }
}
