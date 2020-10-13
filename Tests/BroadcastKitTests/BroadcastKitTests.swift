import XCTest
@testable import BroadcastKit

final class BroadcastKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BroadcastKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
