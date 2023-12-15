//
//  StringExtensionTests.swift
//  CurrencyConverterTests
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation
import XCTest
@testable import CurrencyConverter

class StringExtensionTests: XCTestCase {

    func testDecimalValue() {
        // Test case 1: Valid decimal string
        XCTAssertEqual("123.45".decimalValue, Decimal(123.45), "Failed for a valid decimal string")

        // Test case 2: Valid integer string
        XCTAssertEqual("987".decimalValue, Decimal(987), "Failed for a valid integer string")

        // Test case 3: Valid string with commas (1,000)
        XCTAssertEqual("1,000".decimalValue, Decimal(1000), "Failed for a string with commas")

        // Test case 4: Invalid string
        XCTAssertNil("Invalid".decimalValue, "Failed for an invalid string")

        // Test case 5: Empty string
        XCTAssertNil("".decimalValue, "Failed for an empty string")

        // Test case 6: String with leading/trailing whitespaces
        XCTAssertEqual("   42.42   ".decimalValue, Decimal(42.42), "Failed for a string with leading/trailing whitespaces")

        // Test case 7: Another valid decimal string
        XCTAssertEqual("0.000001".decimalValue, Decimal(0.000001), "Failed for 0.000001 valid decimal string")
    }
}
