import XCTest

/// Runs Xcode's built-in accessibility audit (contrast, hit regions, Dynamic Type clipping,
/// missing labels, traits) on each top-level screen. Add a screen here whenever you add a tab.
final class AccessibilityAuditTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    /// Runs the audit and logs every issue with the element it was found on.
    @MainActor
    private func audit(_ app: XCUIApplication, for types: XCUIAccessibilityAuditType = .all) throws {
        try app.performAccessibilityAudit(for: types) { issue in
            print("Accessibility issue: \(issue.compactDescription) | \(issue.detailedDescription) | element: \(issue.element?.debugDescription ?? "none")")
            return false
        }
    }

    @MainActor
    func testHomeScreenPassesAudit() throws {
        let app = XCUIApplication()
        app.launch()
        try audit(app)
    }

    @MainActor
    func testSettingsScreenPassesAudit() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        try audit(app)
    }

    @MainActor
    func testHomeAtLargestTextSizePassesAudit() throws {
        let app = XCUIApplication()
        app.launchArguments += ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"]
        app.launch()
        try audit(app, for: [.dynamicType, .textClipped])
    }
}
