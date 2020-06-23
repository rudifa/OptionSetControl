//
//  ShareOptionsTests.swift
//  OptionSetControlTests
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import XCTest

class ShareOptionsTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_ShareOptions() {
        do {
            var opts = EnumeratedOptions<ShareOption>()
            XCTAssertFalse(opts.contains(.booking))
            XCTAssertEqual(opts.rawValue, 0)

            opts.select(.booking)
            XCTAssertEqual(opts.rawValue, 8)
        }
        do {
            var opts = EnumeratedOptions(ShareOption.allCases)
            XCTAssert(opts.contains(.email))
            XCTAssert(opts.contains(.addGroup))
            XCTAssert(opts.contains(.booking))
            XCTAssert(opts.contains(.faceTime))
            XCTAssert(opts.contains(.locked))
            XCTAssert(opts.contains(.warning))
            XCTAssertEqual(opts.rawValue, 63)

            opts.toggle(.addGroup)
            XCTAssertFalse(opts.contains(.addGroup))
        }
        do {
            let opts = EnumeratedOptions<ShareOption>(index: 0)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.email))
        }
        do {
            let opts = EnumeratedOptions<ShareOption>(index: 5)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.locked))
            XCTAssertTrue(opts!.isSelected(atIndex: 5))
            XCTAssertFalse(opts!.isSelected(atIndex: 0))
        }
        XCTAssertNil(EnumeratedOptions<ShareOption>(index: -1))
        XCTAssertNil(EnumeratedOptions<ShareOption>(index: 6))

        do {
            let opts = EnumeratedOptions<ShareOption>(rawValue: 5)
            XCTAssertEqual(opts!.rawValue, 5)
            XCTAssert(opts!.contains(.email))
            XCTAssertFalse(opts!.contains(.addGroup))
            XCTAssertFalse(opts!.contains(.booking))
            XCTAssert(opts!.contains(.faceTime))
            XCTAssertFalse(opts!.contains(.locked))
            XCTAssertFalse(opts!.contains(.warning))
        }
        do {
            let rawValues = EnumeratedOptions<ShareOption>.rawValues
            XCTAssertEqual(rawValues, ["envelope", "person.3", "video", "timer", "exclamationmark.triangle", "lock"])
        }
    }
}
