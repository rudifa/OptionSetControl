//
//  ShareOptions.swift
//  Stick-Print
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Eric PAJOT. All rights reserved.
//

import Foundation

// see https://developer.apple.com/documentation/swift/optionset
// see https://cocoacasts.com/how-to-work-with-bitmasks-in-swift/
// see https://cocoacasts.com/how-to-create-a-custom-control-using-a-bitmask
// see https://github.com/bartjacobs/HowToCreateACustomControlUsingABitmask
// see https://nshipster.com/optionset/

struct ShareOptions: OptionSet {
    let rawValue: Int

    static let email = ShareOptions(rawValue: 1 << 0)
    static let addGroup = ShareOptions(rawValue: 1 << 1)
    static let faceTime = ShareOptions(rawValue: 1 << 2)
    static let booking = ShareOptions(rawValue: 1 << 3)
    static let warning = ShareOptions(rawValue: 1 << 4)
    static let lock = ShareOptions(rawValue: 1 << 5)

    static let all: ShareOptions = [.email, .addGroup, .faceTime, .booking, .warning, .lock]

    mutating func toggle(option: ShareOptions) {
        if contains(option) {
            remove(option)
        } else {
            insert(option)
        }
    }

    func isSelected(index: Int) -> Bool {
        guard let option = ShareOptions(index: index) else { return false }
        return contains(option)
    }
}

extension ShareOptions {
    init?(index: Int) {
        if index >= 0, index <= 5 {
            self = ShareOptions(rawValue: 1 << index)
        } else {
            return nil
        }
    }
}
