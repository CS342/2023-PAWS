//
// This source file is part of the CS342 2023 PAWS Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import XCTest
import XCTestExtensions
import XCTHealthKit


class HealthKitUploadTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        try disablePasswordAutofill()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["--showOnboarding"]
        app.deleteAndLaunch(withSpringboardAppName: "PAWS")
    }
}

extension XCUIApplication {
    fileprivate func navigateToMockUpload() throws {
        XCTAssertTrue(tabBars["Tab Bar"].buttons["Reports"].waitForExistence(timeout: 2))
        tabBars["Tab Bar"].buttons["Reports"].tap()
    }
}
