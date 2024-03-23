//
//  ExchangeRateServiceTests.swift
//  CurrencyConverterTests
//
//  Created by Ankush Kushwaha on 23/03/24.
//

import Foundation

import XCTest
@testable import CurrencyConverter

class ExchangeRateServiceTests: XCTestCase {
    
    var sut: ExchangeRateService!
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchTransactionsSuccess() async throws {
        let mockSession = MockTestURLSession()
        sut = ExchangeRateService(mockSession)
        
        let result = await sut.fetchExchangeRates(_for: "USD")
        
        switch result {
        case .success(let data):
            
            XCTAssertEqual(data.base, "USD")
            XCTAssertTrue(data.rates.count > 0)
            
        case .failure(let err):
            XCTFail("Could not fetch exchange rates: \(err)")
        }
    }
    
    func testFetchTransactionsFail() async throws {
        
        var mockSession = MockTestURLSession()
        mockSession.error = MockError.dataError
        
        sut = ExchangeRateService(mockSession)
        
        let result = await sut.fetchExchangeRates(_for: "USD")
        
        switch result {
        case .success(_):
            XCTFail("ExchangeRateService Should not succeed.")
            
        case .failure(let err):
            XCTAssertEqual(MockError.dataError, err as! MockError)
        }
    }
}
