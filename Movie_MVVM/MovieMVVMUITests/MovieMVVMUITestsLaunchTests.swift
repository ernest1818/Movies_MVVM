// MovieMVVMUITestsLaunchTests.swift
// Copyright © Avagyan Ernest. All rights reserved.

import XCTest

final class MovieMVVMUITestsLaunchTests: XCTestCase {
    // MARK: - Public Properties

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    // MARK: - Public Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
