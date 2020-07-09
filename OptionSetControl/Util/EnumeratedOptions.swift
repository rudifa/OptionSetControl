//
//  EnumeratedOptions.swift
//  OptionSetControl
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import Foundation

protocol Option: RawRepresentable, Hashable, CaseIterable {}

/// Storage for a set of options enumerated by OE
struct EnumeratedOptions<OE> where OE: Option {
    /// Storage
    private var options: Set<OE> = []

    /// Initialize from an array of options
    init(_ options: [OE] = []) {
        for option in options {
            self.options.insert(option)
        }
    }

    /// Initialize with a single option from index
    /// - Parameter index: into the enum OE
    init?(index: Int) {
        guard let eCase = enumCase(index: index) else { return nil }
        options.insert(eCase)
    }

    /// Initialize from  bit-encoded options
    /// - Parameter rawValue: bit-encoded options
    init?(bitEncoded: Int) {
        guard bitEncoded >= 0, bitEncoded < (1 << OE.allCases.count) else { return nil }
        for index in 0 ..< OE.allCases.count {
            if bitEncoded & (1 << index) != 0 {
                options.insert(Array(OE.allCases)[index])
            }
        }
    }

    /// Returns the option case for the index, nil if invalid
    /// - Parameter index: into the enum OE
    private func enumCase(index: Int) -> OE? {
        guard index >= 0, index < OE.allCases.count else { return nil }
        return Array(OE.allCases)[index]
    }

    /// Returns current options, bit-encoded
    var bitEncoded: Int {
        var encoded = 0
        for (index, element) in OE.allCases.enumerated() {
            if contains(element) {
                encoded |= (1 << index)
            }
        }
        return encoded
    }

    /// Returns true of the option is selected
    /// - Parameter option
    func contains(_ option: OE) -> Bool {
        return options.contains(option)
    }

    /// Selects the option
    /// - Parameter option
    mutating func select(_ option: OE) {
        options.insert(option)
    }

    /// Toggles the option
    /// - Parameter option
    mutating func toggle(_ option: OE) {
        if options.contains(option) {
            options.remove(option)
        } else {
            options.insert(option)
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
        guard let eCase = enumCase(index: atIndex) else { return false }
        return options.contains(eCase)
    }

    /// Returns the array of rawValues defined by OE
    static var rawValues: [OE.RawValue] {
        return Array(OE.allCases).map { $0.rawValue }
    }
}
