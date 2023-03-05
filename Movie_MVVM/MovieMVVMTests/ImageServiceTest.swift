// ImageServiceTest.swift
// Copyright © Avagyan Ernest. All rights reserved.

@testable import Movie_MVVM
import XCTest

final class ImageServiceTest: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let testText = "test"
    }

    // MARK: - Public Properties

    var imageService: ImageServiceProtocol!

    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        imageService = MockImageService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        imageService = nil
    }

    func testImageService() {
        imageService.getImage(byUrl: Constants.testText) { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data, Constants.testText.data(using: .utf8))
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func testPerformanceExample() throws {
        measure {}
    }
}
