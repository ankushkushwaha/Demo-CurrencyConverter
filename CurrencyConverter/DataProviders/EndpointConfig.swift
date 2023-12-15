//
//  EndpointConfig.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

struct EndpointConfig {
    private let appId = "18d5f4c02d504e6eb7c837314c2ce730"
    private let baseUrl = "https://openexchangerates.org/api"
    
    var latestExchangeRatesUrl: String {
        "\(baseUrl)/latest.json?app_id=\(appId)"
    }
}
