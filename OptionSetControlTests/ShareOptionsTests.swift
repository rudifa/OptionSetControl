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
            XCTAssertTrue(opts!.isSelected(index: 5))
            XCTAssertFalse(opts!.isSelected(index: 0))
        }
        XCTAssertNil(ShareOptions(index: -1))
        XCTAssertNil(ShareOptions(index: 6))
    }
}

protocol Option: RawRepresentable, Hashable, CaseIterable {}

enum ShareOpt: String, Option {
    case email = "envelope"
    case addGroup = "person.3"
    case faceTime = "video"
    case booking = "timer"
    case warning = "exclamationmark.triangle"
    case lock
}

struct Options<OE> where OE: Option {
    private var options: Set<OE> = []

    init(_ options: [OE] = []) {
        for option in options {
            self.options.insert(option)
        }
    }

    init?(index: Int) {
//        guard index >= 0, index < OE.allCases.count else { return nil }
//        options.insert(Array(OE.allCases)[index])

        guard let eCase = enumCase(index: index) else { return nil }
        options.insert(eCase)
    }

    init?(rawValue: Int) {
        guard rawValue >= 0, rawValue < (1 << OE.allCases.count) else { return nil }
        for index in 0 ..< OE.allCases.count {
            if rawValue & (1 << index) != 0 {
                options.insert(Array(OE.allCases)[index])
            }
        }
    }

    private func enumCase(index: Int) -> OE? {
        guard index >= 0, index < OE.allCases.count else { return nil }
        return Array(OE.allCases)[index]
    }

    var rawValue: Int {
        var rawValue = 0
        for (index, element) in OE.allCases.enumerated() {
            if contains(element) {
                rawValue |= (1 << index)
            }
        }
        return rawValue
    }

    func contains(_ option: OE) -> Bool {
        return options.contains(option)
    }

    mutating func select(_ option: OE) {
        options.insert(option)
    }

    mutating func toggle(_ option: OE) {
        if options.contains(option) {
            options.remove(option)
        } else {
            options.insert(option)
        }
    }

    func isSelected(index: Int) -> Bool {
        guard let eCase = enumCase(index: index) else { return false }
        return options.contains(eCase)
    }

    static var rawValues: [OE.RawValue] {
        return Array(OE.allCases).map { $0.rawValue }
    }
}

class ShareOptionsTests2: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_ShareOptions2() {
        do {
            var opts = Options<ShareOpt>()
            XCTAssertFalse(opts.contains(.booking))
            XCTAssertEqual(opts.rawValue, 0)

            opts.select(.booking)
            XCTAssertEqual(opts.rawValue, 8)
        }
        do {
            var opts = Options(ShareOpt.allCases)
            XCTAssert(opts.contains(.email))
            XCTAssert(opts.contains(.addGroup))
            XCTAssert(opts.contains(.booking))
            XCTAssert(opts.contains(.faceTime))
            XCTAssert(opts.contains(.lock))
            XCTAssert(opts.contains(.warning))
            XCTAssertEqual(opts.rawValue, 63)

            opts.toggle(.addGroup)
            XCTAssertFalse(opts.contains(.addGroup))
        }
        do {
            let opts = Options<ShareOpt>(index: 0)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.email))
        }
        do {
            let opts = Options<ShareOpt>(index: 5)
            XCTAssertNotNil(opts)
            XCTAssert(opts!.contains(.lock))
            XCTAssertTrue(opts!.isSelected(index: 5))
            XCTAssertFalse(opts!.isSelected(index: 0))
        }
        XCTAssertNil(Options<ShareOpt>(index: -1))
        XCTAssertNil(Options<ShareOpt>(index: 6))

        do {
            let opts = Options<ShareOpt>(rawValue: 5)
            XCTAssertEqual(opts!.rawValue, 5)
            XCTAssert(opts!.contains(.email))
            XCTAssertFalse(opts!.contains(.addGroup))
            XCTAssertFalse(opts!.contains(.booking))
            XCTAssert(opts!.contains(.faceTime))
            XCTAssertFalse(opts!.contains(.lock))
            XCTAssertFalse(opts!.contains(.warning))
        }
        do {
            let rawValues = Options<ShareOpt>.rawValues
            XCTAssertEqual(rawValues, ["envelope", "person.3", "video", "timer", "exclamationmark.triangle", "lock"])
        }
    }
}
