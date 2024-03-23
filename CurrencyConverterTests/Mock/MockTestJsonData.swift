//
//  MockTestJsonData.swift
//  CurrencyConverterTests
//
//  Created by Ankush Kushwaha on 23/03/24.
//

import Foundation

class MockTestJsonData {
    
    func getJsonData() -> Data? {
        // MockTestJsonData is declared as class to get test bundle, otherwise struct is enough
        let bundle = Bundle(for: type(of: self))
        
        guard let fileURL = bundle.url(forResource: "MockExchangeRatesData", withExtension: "json") else {
            print("JSON file not found")
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            return jsonData
        } catch {
            print("Error fething data from mock json file: \(error)")
            return nil
        }
    }
}
