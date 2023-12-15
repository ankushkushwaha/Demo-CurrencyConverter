//
//  DecimalExtensionTests.swift
//  CurrencyConverterTests
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation
import XCTest
@testable import CurrencyConverter

class DecimalExtensionTests: XCTestCase {

    func testPrettyStringValue() {
        
        // number less than 0.0000001
        XCTAssertEqual(Decimal(0.000000099).prettyStringValue, "0.000000099", "Failed for magnitude less than 0.0000001")

        // number less than 0.00001
        XCTAssertEqual(Decimal(0.0000099).prettyStringValue, "0.0000099", "Failed for magnitude less than 0.00001")

        // number less than 0.001
        XCTAssertEqual(Decimal(0.00099).prettyStringValue, "0.00099", "Failed for magnitude less than 0.001")

        // number less than 0.1
        XCTAssertEqual(Decimal(0.099).prettyStringValue, "0.099", "Failed for magnitude less than 0.1")

        // number grater than 1
        XCTAssertEqual(Decimal(2).prettyStringValue, "2.0", "Failed for magnitude greater than or equal to 0.1")
        
        // number grater than 1 with decimals
        XCTAssertEqual(Decimal(2.04).prettyStringValue, "2.04", "Failed for magnitude greater than or equal to 0.1")

    }
}
