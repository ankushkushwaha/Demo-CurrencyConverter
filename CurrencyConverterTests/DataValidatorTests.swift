//
//  DataValidatorTests.swift
//  CurrencyConverterTests
//
//  Created by ankush kushwaha on 09/12/23.
//

import XCTest
@testable import CurrencyConverter

class DataValidatorTests: XCTestCase {
    
    var sut: DataValidator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DataValidator()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testIsDataValid() {
        let currentTimestamp = Date().timeIntervalSince1970
        
        // timestamp from 29 minutes ago
        let timStamp = currentTimestamp - (29 * 60)
        
        let isValid = sut.isDataValid(timestamp: Int(timStamp))
        
        XCTAssertTrue(isValid)
    }
    
    func testIsDataValidEdgeCase() {
        let currentTimestamp = Date().timeIntervalSince1970
        
        // timestamp from 30 minutes ago
        let timStamp = currentTimestamp - (30 * 60)
        
        let isValid = sut.isDataValid(timestamp: Int(timStamp))
        
        XCTAssertTrue(isValid)
    }
    
    func testForInvalidData() {
        let currentTimestamp = Date().timeIntervalSince1970
        
        // timestamp from 31 minutes ago
        let timStamp = currentTimestamp - (31 * 60)
        
        let isValid = sut.isDataValid(timestamp: Int(timStamp))
        
        XCTAssertFalse(isValid)
    }
}
