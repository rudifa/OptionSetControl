//
//  ShareOption.swift
//  OptionSetControl
//
//  Created by Rudolf Farkas on 23.06.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import Foundation

// protocol Option: RawRepresentable, Hashable, CaseIterable {}

/// Application-specific enumeration of available options
enum ShareOption: String, Option {
    case geoLoc = "pin"
    case publicScope = "scope"
    case booking = "clock"
    case warning = "exclamationmark.triangle"
    case addGroup = "person.3"
    case faceTime = "video"
}
