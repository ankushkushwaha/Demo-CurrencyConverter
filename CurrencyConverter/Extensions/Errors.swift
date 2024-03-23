//
//  Errors.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

enum DataError: Error {
    case networkError
    var errorMessage: String {
        switch self {
        case .networkError:
            return "Could not fetch data. Please try again later."
        }
    }
}

enum NetworkingError: Error {
    case invalidURL
    case requestFailed(description: String)
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid Url."
        case .requestFailed(_):
            return "Could not fetch data. Please try again later."
        }
    }
}
