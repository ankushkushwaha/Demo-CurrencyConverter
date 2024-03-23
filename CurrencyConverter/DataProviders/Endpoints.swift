//
//  Endpoints.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

struct Endpoints {
    private static let appId = "18d5f4c02d504e6eb7c837314c2ce730"
    private static let baseUrl = "https://openexchangerates.org/api"
    
    static var exchangeRates: String {
        "\(baseUrl)/latest.json?app_id=\(appId)"
    }
}
