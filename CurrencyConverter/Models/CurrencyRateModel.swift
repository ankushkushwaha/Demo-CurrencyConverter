//
//  CurrencyRateModel.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

struct CurrencyRateModel: Hashable {
    let currencySymbol: String
    let rate: Decimal
    let convertedRate: Decimal?
}
