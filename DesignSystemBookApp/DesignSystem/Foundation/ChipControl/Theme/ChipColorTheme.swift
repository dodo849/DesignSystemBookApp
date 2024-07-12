//
//  ChipColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/13/24.
//

import Foundation

protocol ChipColorTheme {
    func itemBackgroundColor(state: ChipState) -> UniversalColor
    func itemForegroundColor(state: ChipState) -> UniversalColor
    func itemShadowColor(state: ChipState) -> UniversalColor
    func itemBorderColor(state: ChipState) -> UniversalColor
    func containerBackgroundColor() -> UniversalColor
}
