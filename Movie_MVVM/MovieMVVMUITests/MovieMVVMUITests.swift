// MovieMVVMUITests.swift
// Copyright © Avagyan Ernest. All rights reserved.

import XCTest

/// Тесты юай элементов
final class MovieMVVMUITests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let popularSegmentName = "Popular"
        static let topSegmentName = "Top"
        static let newSegmentName = "New"
        static let sleepNumber: UInt32 = 2
        static let movieButtonName = "Movie"
    }

    // MARK: - Public Methods

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        app.swipeUp()
        app.swipeDown()
        app.buttons[Constants.topSegmentName].tap()
        app.buttons[Constants.newSegmentName].tap()
        app.buttons[Constants.popularSegmentName].tap()
        app.tap()
        app.swipeUp()
        sleep(Constants.sleepNumber)
        app.navigationBars.buttons[Constants.movieButtonName].tap()
        app.swipeUp()
        app.swipeUp()
        app.swipeDown()
        sleep(Constants.sleepNumber)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
