//
//  DataStoreServiceTests.swift
//  CurrencyConverterTests
//
//  Created by ankush kushwaha on 09/12/23.
//

import XCTest
@testable import CurrencyConverter

class DataStoreServiceTests: XCTestCase {
    var userDefaults: UserDefaults!
    var sut: DataStoreService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        
        sut = DataStoreService(defaults: userDefaults)
    }
    
    override func tearDownWithError() throws {
        userDefaults.removeSuite(named: #file)
        userDefaults = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSaveExchageRateData() throws {
        
        guard let data = try MockTestModelProvider().getExchangeRates() else {
            XCTFail("Could not read data from MockExchangeRatesData.json")
            return
        }
        XCTAssertNil(userDefaults.value(forKey: "USD"))
        
        try sut.setExchageRatesForCurrencySymbol("USD", data: data)
        
        XCTAssertNotNil(userDefaults.value(forKey: "USD"))
    }
    
    func testGetSavedData() throws {
        guard let data = try MockTestModelProvider().getExchangeRates() else {
            XCTFail("Could not read data from MockExchangeRatesData.json")
            return
        }
        
        try sut.setExchageRatesForCurrencySymbol("USD", data: data)
        
        let response = sut.getExchageRatesForCurrencySymbol("USD")
        
        XCTAssertEqual(response?.base, "USD")
        XCTAssertEqual(response?.rates["USD"], 1)
    }
}
