// KeychainTest.swift
// Copyright © Avagyan Ernest. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тест кейчейн сервиса
final class KeychainServiceTest: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
        static let testText = "Verification"
        static let testApiString = "testApi"
    }

    // MARK: - Private Properties

    private var keychainService: KeychainServiceProtocol?

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        keychainService = MockKeychainService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        keychainService = nil
    }

    func testKeychainService() {
        let mockText = Constants.testText
        keychainService?.save(text: mockText, forKey: .test)
        let result = keychainService?.get(forKey: .test)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, Constants.testApiString)
    }

    func testPerformanceExample() throws {
        measure {}
    }
}
