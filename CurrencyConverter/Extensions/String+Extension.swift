//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

extension String {
    var decimalValue: Decimal? {
        Self.numberFormatter.number(from: self)?.decimalValue
    }
}

extension String {
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
}

