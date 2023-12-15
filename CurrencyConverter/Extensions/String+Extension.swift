//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

extension String {
    var decimalValue: Decimal? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter.number(from: self)?.decimalValue
    }
}
