    import XCTest
    @testable import SwiftTooltip

    final class SwiftTooltipTests: XCTestCase {
        
        func testExample() {
            let message = "Tooltip message"
            let tooltip = TooltipItem(message: message, calloutConfig: .default)
            XCTAssertEqual(tooltip.message, message)
        }
    }
