import XCTest
@testable import Toasty

final class ToastyTests: XCTestCase {
    
    func testInit() {
        let toast = ToastBanner(type: .regular, title: "Title", subtitle: "Subtitle", style: .none)
        XCTAssertEqual(toast.type, .regular)
        XCTAssertEqual(toast.title, "Title")
        XCTAssertEqual(toast.subtitle, "Subtitle")
    }

    static var allTests = [
        ("testInit", testInit),
    ]
}
