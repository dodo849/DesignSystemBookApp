//
//  Rounded+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import Foundation

extension RoundedOffset {
    static let zero = RoundedOffset()
    static let extraSmall = RoundedOffset(all: 4)
    static let xsmall = RoundedOffset(all: 8)
    static let small = RoundedOffset(all: 10)
    static let medium = RoundedOffset(all: 12)
    static let large = RoundedOffset(all: 16)
    static let xlarge = RoundedOffset(all: 20)
    static let infinity = RoundedOffset(all: .infinity)
}
