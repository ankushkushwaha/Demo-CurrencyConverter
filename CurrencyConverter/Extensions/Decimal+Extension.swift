//
//  Decimal+Extension.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

extension Decimal {
    var prettyStringValue: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 1
        
        if self < 0.0000001 {
            numberFormatter.maximumFractionDigits = 9
        } else if self < 0.000001 {
            numberFormatter.maximumFractionDigits = 8
        } else if self < 0.00001 {
            numberFormatter.maximumFractionDigits = 7
        } else if self < 0.0001 {
            numberFormatter.maximumFractionDigits = 6
        } else if self < 0.001 {
            numberFormatter.maximumFractionDigits = 5
        } else if self < 0.01 {
            numberFormatter.maximumFractionDigits = 4
        } else if self < 0.1 {
            numberFormatter.maximumFractionDigits = 3
        } else {
            numberFormatter.maximumFractionDigits = 2
        }
        return numberFormatter.string(from: self as NSDecimalNumber)
    }
}
