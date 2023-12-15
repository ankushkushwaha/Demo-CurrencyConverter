//
//  CurrencyConverterApp.swift
//  ExchangeRateResponse
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let base: String
    let rates: [String: Decimal]
    let timestamp: Int
}
