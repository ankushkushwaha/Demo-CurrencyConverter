//
//  URLSession+Extension.swift
//  CurrencyConverter
//
//  Created by ankush kushwaha on 09/12/23.
//

import Foundation

extension URLSession {
    
    func fetchData<T: Decodable>(url: String) async -> Result<T, Error> {
        
        do {
            guard let url = URL(string: url) else {
                return .failure(NetworkingError.invalidURL)
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        }
        catch {
            return .failure(NetworkingError.requestFailed(description: error.localizedDescription))
        }
    }
}
