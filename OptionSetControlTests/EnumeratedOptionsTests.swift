//
//  EnumeratedOptionsTests.swift v.0.1.1
//  OptionSetControlTests
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import XCTest

// protocol Option: RawRepresentable, Hashable, CaseIterable {}

enum OptionExample: String, Option {
    case locating = "pin"
    case scoping = "scope"
    case clocking = "clock"
    case warning = "exclamationmark.triangle"
    case meeting = "person.3"
    case video = "video"
}

class EnumeratedOptionsTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_EnumeratedOptions() {
        do {
            var opts = EnumeratedOptions<OptionExample>()
            XCTAssertFalse(opts.contains(.clocking))
            XCTAssertEqual(opts.bitEncoded, 0)

            opts.select(.clocking)
            XCTAssertEqual(opts.bitEncoded, 4)
        }
        do {
            var opts = EnumeratedOptions(OptionExample.allCases)
            XCTAssert(opts.contains(.locating))
            XCTAssert(opts.contains(.meeting))
            XCTAssert(opts.contains(.clocking))
            XCTAssert(opts.contains(.video))
            XCTAssert(opts.contains(.scoping))
            XCTAssert(opts.contains(.warning))
            XCTAssertEqual(opts.bitEncoded, 63)

            opts.toggle(.meeting)
            XCTAssertFalse(opts.contains(.meeting))
        }
        do {
            let opts = EnumeratedOptions<OptionExample>(index: 0)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.locating))
        }
        do {
            let opts = EnumeratedOptions<OptionExample>(index: 5)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.video))
            XCTAssertTrue(opts!.isSelected(atIndex: 5))
            XCTAssertFalse(opts!.isSelected(atIndex: 0))
        }
        XCTAssertNil(EnumeratedOptions<OptionExample>(index: -1))
        XCTAssertNil(EnumeratedOptions<OptionExample>(index: 6))

        do {
            let opts = EnumeratedOptions<OptionExample>(bitEncoded: 5)
            XCTAssertEqual(opts!.bitEncoded, 5)
            XCTAssert(opts!.contains(.locating))
            XCTAssertFalse(opts!.contains(.meeting))
            XCTAssert(opts!.contains(.clocking))
            XCTAssertFalse(opts!.contains(.video))
            XCTAssertFalse(opts!.contains(.scoping))
            XCTAssertFalse(opts!.contains(.warning))
        }
        do {
            let rawValues = EnumeratedOptions<OptionExample>.rawValues
            XCTAssertEqual(rawValues, ["pin", "scope", "clock", "exclamationmark.triangle", "person.3", "video"])
        }
    }
}
