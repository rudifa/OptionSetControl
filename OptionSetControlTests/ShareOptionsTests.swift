//
//  ShareOptionsTests.swift
//  Stick-PrintTests
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Eric PAJOT. All rights reserved.
//

import XCTest

class ShareOptionsTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_ShareOptions() {
        do {
            let opts = ShareOptions()
            XCTAssertFalse(opts.contains(.booking))
            XCTAssertEqual(opts.rawValue, 0)
        }
        do {
            var opts = ShareOptions(rawValue: ShareOptions.all.rawValue)
            XCTAssert(opts.contains(.email))
            XCTAssert(opts.contains(.addGroup))
            XCTAssert(opts.contains(.booking))
            XCTAssert(opts.contains(.faceTime))
            XCTAssert(opts.contains(.lock))
            XCTAssert(opts.contains(.warning))
            XCTAssertEqual(opts.rawValue, 63)

            opts.toggle(option: ShareOptions.addGroup)
            XCTAssertFalse(opts.contains(.addGroup))
        }
        do {
            let opts = ShareOptions(index: 0)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.email))
        }
        do {
            let opts = ShareOptions(index: 5)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.lock))
            XCTAssertTrue(opts!.isSet(index: 5))
            XCTAssertFalse(opts!.isSet(index: 0))
        }
        XCTAssertNil(ShareOptions(index: -1))
        XCTAssertNil(ShareOptions(index: 6))
    }
}
