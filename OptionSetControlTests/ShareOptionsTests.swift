//
//  ShareOptionsTests.swift
//  OptionSetControlTests
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import XCTest

// enum ShareOption: String, Option {
//    case geoLoc = "pin"
//    case publicScope = "scope"
//    case booking = "clock"
//    case warning = "exclamationmark.triangle"
//    case addGroup = "person.3"
//    case faceTime = "video"
// }

class ShareOptionsTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_ShareOptions() {
        do {
            var opts = EnumeratedOptions<ShareOption>()
            XCTAssertFalse(opts.contains(.booking))
            XCTAssertEqual(opts.bitEncoded, 0)

            opts.select(.booking)
            XCTAssertEqual(opts.bitEncoded, 4)
        }
        do {
            var opts = EnumeratedOptions(ShareOption.allCases)
            XCTAssert(opts.contains(.geoLoc))
            XCTAssert(opts.contains(.addGroup))
            XCTAssert(opts.contains(.booking))
            XCTAssert(opts.contains(.faceTime))
            XCTAssert(opts.contains(.publicScope))
            XCTAssert(opts.contains(.warning))
            XCTAssertEqual(opts.bitEncoded, 63)

            opts.toggle(.addGroup)
            XCTAssertFalse(opts.contains(.addGroup))
        }
        do {
            let opts = EnumeratedOptions<ShareOption>(index: 0)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.geoLoc))
        }
        do {
            let opts = EnumeratedOptions<ShareOption>(index: 5)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.faceTime))
            XCTAssertTrue(opts!.isSelected(atIndex: 5))
            XCTAssertFalse(opts!.isSelected(atIndex: 0))
        }
        XCTAssertNil(EnumeratedOptions<ShareOption>(index: -1))
        XCTAssertNil(EnumeratedOptions<ShareOption>(index: 6))

        do {
            let opts = EnumeratedOptions<ShareOption>(bitEncoded: 5)
            XCTAssertEqual(opts!.bitEncoded, 5)
            XCTAssert(opts!.contains(.geoLoc))
            XCTAssertFalse(opts!.contains(.addGroup))
            XCTAssert(opts!.contains(.booking))
            XCTAssertFalse(opts!.contains(.faceTime))
            XCTAssertFalse(opts!.contains(.publicScope))
            XCTAssertFalse(opts!.contains(.warning))
        }
        do {
            let rawValues = EnumeratedOptions<ShareOption>.rawValues
            XCTAssertEqual(rawValues, ["pin", "scope", "clock", "exclamationmark.triangle", "person.3", "video"])
        }
    }
}
