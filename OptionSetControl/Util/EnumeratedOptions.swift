//
//  EnumeratedOptions.swift v.0.1.2
//  OptionSetControl
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import Foundation

protocol Option: RawRepresentable, Hashable, CaseIterable {}

/// Storage for a set of options enumerated by OE
struct EnumeratedOptions<OE> where OE: Option {
    /// local storage
    private var bitEncodedOptions: Int = 0

    private func index(of option: OE) -> Int {
        return Array(OE.allCases).firstIndex(of: option)!
    }

    private func bitMask(for option: OE) -> Int {
        return 1 << index(of: option)
    }

    /// Returns the option case for the index, nil if invalid
    /// - Parameter index: into the enum OE
    private func enumCase(index: Int) -> OE? {
        guard index >= 0, index < OE.allCases.count else { return nil }
        return Array(OE.allCases)[index]
    }

    /// Initialize from an array of options
    init(_ options: [OE] = []) {
        for option in options {
            bitEncodedOptions |= bitMask(for: option)
        }
    }

    /// Initialize with a single option from index
    /// - Parameter index: into the enum OE
    init?(index: Int) {
        guard let eCase = enumCase(index: index) else { return nil }
        bitEncodedOptions |= bitMask(for: eCase)
    }

    /// Initialize from  bit-encoded options
    /// - Parameter rawValue: bit-encoded options
    init?(bitEncoded: Int) {
        guard bitEncoded >= 0, bitEncoded < (1 << OE.allCases.count) else { return nil }
        bitEncodedOptions = bitEncoded
    }

    /// Returns current options, bit-encoded
    var bitEncoded: Int {
        return bitEncodedOptions
    }

    /// Returns true of the option is selected
    /// - Parameter option
    func contains(_ option: OE) -> Bool {
        return bitEncodedOptions & bitMask(for: option) != 0
    }

    /// Selects the option
    /// - Parameter option
    mutating func select(_ option: OE) {
        bitEncodedOptions |= bitMask(for: option)
    }

    /// Toggles the option
    /// - Parameter option
    mutating func toggle(_ option: OE) {
        if contains(option) {
            bitEncodedOptions &= ~bitMask(for: option)
        } else {
            bitEncodedOptions |= bitMask(for: option)
        }
    }

    /// Toggles the option at index
    /// - Parameter atIndex
    mutating func toggle(atIndex: Int) {
        guard let eCase = enumCase(index: atIndex) else { return }
        toggle(eCase)
    }

    /// Returns true if the option at index is selected
    /// - Parameter atIndex
    func isSelected(atIndex: Int) -> Bool {
        guard let option = enumCase(index: atIndex) else { return false }
        return contains(option)
    }

    /// Returns the array of rawValues defined by OE
    static var rawValues: [OE.RawValue] {
        return Array(OE.allCases).map { $0.rawValue }
    }
}
