//
//  EndpointConfigTests.swift
//  CurrencyConverterTests
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation
import XCTest
@testable import CurrencyConverter

class EndpointConfigTests: XCTestCase {

    func testLatestExchangeRatesUrl() {
        let endpointConfig = EndpointConfig()

        let url = endpointConfig.latestExchangeRatesUrl

        XCTAssertEqual(url, "https://openexchangerates.org/api/latest.json?app_id=18d5f4c02d504e6eb7c837314c2ce730", "URL should match the expected value")
    }
}
