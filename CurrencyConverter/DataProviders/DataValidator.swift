//
//  DataValidator.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

struct DataValidator {
    
    private let timeToExpireFethedData = 60 * 30 // 30 minutes
    
    func isDataValid(timestamp: Int) -> Bool {
        
        let currentTimestamp = Date().timeIntervalSince1970
        let timeDifference = Int(currentTimestamp) - timestamp
        
        if timeDifference > timeToExpireFethedData {
            return false
        }
        return true
    }
}
