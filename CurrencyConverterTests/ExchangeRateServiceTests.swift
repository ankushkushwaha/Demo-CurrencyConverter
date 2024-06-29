//
//  ExchangeRateServiceTests.swift
//  CurrencyConverterTests
//
//  Created by Ankush Kushwaha on 23/03/24.
//

import Foundation

import XCTest
@testable import CurrencyConverter

class ExchangeRateServiceTests: XCTestCase {
    
    var sut: ExchangeRateService!
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchTransactionsSuccess() async throws {
        let mockSession = MockTestURLSession()
        sut = ExchangeRateService(mockSession)
        
        let result = await sut.fetchExchangeRates(_for: "USD")
        
        switch result {
        case .success(let data):
            
            XCTAssertEqual(data.base, "USD")
            XCTAssertTrue(data.rates.count > 0)
            
        case .failure(let err):
            XCTFail("Could not fetch exchange rates: \(err)")
        }
    }
    
    func testFetchTransactionsFail() async throws {
        
        var mockSession = MockTestURLSession()
        mockSession.error = MockTestURLSession.DataError.mockDataError
        
        sut = ExchangeRateService(mockSession)
        
        let result = await sut.fetchExchangeRates(_for: "USD")
        
        switch result {
        case .success(_):
            XCTFail("ExchangeRateService Should not succeed.")
            
        case .failure(let err):
            XCTAssertEqual(MockTestURLSession.DataError.mockDataError, err as! MockTestURLSession.DataError)
        }
    }
}


struct MockTestURLSession: URLSessionProtocol {

    enum DataError: Error {
        case mockDataError
    }

    var error: Error?

    func fetchData(url: URL) async throws -> (Data, URLResponse) {

        if let error = error {
            throw error
        }

        return try await mockFetchData(url: url)
    }

    private func mockFetchData(url: URL) async throws -> (Data, URLResponse) {

        let fakeSuccessResponse = HTTPURLResponse(url: url,
                                                  statusCode: 200,
                                                  httpVersion: "HTTP/1.1",
                                                  headerFields: nil)

        let mockData = MockJsonData().getJsonData()

        guard let mockData = mockData,
              let response = fakeSuccessResponse else {
            throw DataError.mockDataError
        }
        return (mockData, response)
    }
}
