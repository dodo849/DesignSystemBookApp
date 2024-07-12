//
//  BasicChipColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

struct BasicChipColorTheme: ChipColorTheme {
    private let variant: BasicChipVariant
    private let color: BasicChipColor
    
    init(
        variant: BasicChipVariant,
        color: BasicChipColor
    ) {
        self.variant = variant
        self.color = color
    }
    
    func itemBackgroundColor(state: ChipState) -> UniversalColor {
        switch variant {
        case .fillAndOutline:
            return .init(fillAndOutlineItemBackgroundColor(state: state))
        case .deepAndSoft:
            return .init(deepAndSoftItemBackgroundColor(state: state))
        }
    }
    
    func itemForegroundColor(state: ChipState) -> UniversalColor {
        switch variant {
        case .fillAndOutline:
            return .init(fillAndOutlineItemForegroundColor(state: state))
        case .deepAndSoft:
            return .init(deepAndSoftItemForegroundColor(state: state))
        }
    }
    
    func itemBorderColor(state: ChipState) -> UniversalColor {
        if variant == .deepAndSoft { return .init(.clear) }
        
        switch (color, state) {
        case (_, .selected): return .init(.none)
        case (_, .unselected): return .init(.gray03)
        }
    }
    
    /// Not used
    func itemShadowColor(state: ChipState) -> UniversalColor {
        return .init(.clear)
    }
    
    /// Not used
    func containerBackgroundColor() -> UniversalColor {
        return .init(.clear)
    }
}

extension BasicChipColorTheme {
    private func fillAndOutlineItemBackgroundColor(state: ChipState) -> Color {
        switch (color, state) {
        case (_, .unselected): return .none
        case (.primary, .selected): return .init(.basicYellow)
        case (.secondary, .selected): return .init(.basicGreen)
        case (.tertiary, .selected): return .init(.basicPink)
        case (.stone, .selected): return .init(.gray06)
        }
    }
    
    private func deepAndSoftItemBackgroundColor(state: ChipState) -> Color {
        switch (color, state) {
        case (.primary, .unselected): return .init(.basicYellowSoft)
        case (.secondary, .unselected): return .init(.basicGreenSoft)
        case (.tertiary, .unselected): return .init(.basicPinkSoft)
        case (.stone, .unselected): return .init(.gray01)
        case (.primary, .selected): return .init(.basicYellow)
        case (.secondary, .selected): return .init(.basicGreen)
        case (.tertiary, .selected): return .init(.basicPink)
        case (.stone, .selected): return .init(.gray06)
        }
    }
    
    private func fillAndOutlineItemForegroundColor(state: ChipState) -> Color {
        switch (color, state) {
        case (_, .unselected): return .init(.gray05)
        case (_, .selected): return .init(.white)
        }
    }
    
    private func deepAndSoftItemForegroundColor(state: ChipState) -> Color {
        switch (color, state) {
        case (_, .selected): return .init(.white)
        case (.primary, .unselected): return .init(.basicYellow)
        case (.secondary, .unselected): return .init(.basicGreen)
        case (.tertiary, .unselected): return .init(.basicPink)
        case (.stone, .unselected): return .init(.gray05)
        }
    }
}
