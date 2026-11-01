import XCTest

/// Runs Xcode's built-in accessibility audit (contrast, hit regions, Dynamic Type clipping,
/// missing labels, traits) on each top-level screen. Add a screen here whenever you add a tab.
final class AccessibilityAuditTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    @MainActor
    func testHomeScreenPassesAudit() throws {
        let app = XCUIApplication()
        app.launch()
        try app.performAccessibilityAudit()
    }

    @MainActor
    func testSettingsScreenPassesAudit() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        try app.performAccessibilityAudit()
    }

    @MainActor
    func testHomeAtLargestTextSizePassesAudit() throws {
        let app = XCUIApplication()
        app.launchArguments += ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"]
        app.launch()
        try app.performAccessibilityAudit(for: [.dynamicType, .textClipped])
    }
}
