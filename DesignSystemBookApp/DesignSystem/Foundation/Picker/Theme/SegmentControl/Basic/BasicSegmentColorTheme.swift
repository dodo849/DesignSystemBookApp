//
//  BasicToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import Foundation

struct BasicSegmentColorTheme: PickerColorTheme {
    private let variant: BasicSegmentVariant
    private let color: BasicSegmentColor
    
    init(
        variant: BasicSegmentVariant,
        color: BasicSegmentColor
    ) {
        self.variant = variant
        self.color = color
    }
    
    func itemBackgroundColor(state: PickerState) -> UniversalColor {
        switch (color, state) {
        case (_, .unselected): return .init(.gray03)
        case (.primary, .selected): return .init(.basicYellow)
        case (.secondary, .selected): return .init(.basicGreen)
        case (.tertiary, .selected): return .init(.basicPink)
        case (.soft, .selected): return .init(.basicBackground)
        case (.stone, .selected): return .init(.gray05)
        }
    }
    
    func itemForegroundColor(state: PickerState) -> UniversalColor {
        // for underline
        switch (variant, state) {
        case (.underline, .selected):
            switch color {
            case .primary: return .init(.basicYellow)
            case .secondary: return .init(.basicGreen)
            case .tertiary: return .init(.basicPink)
            case .soft: return .init(.basicText)
            case .stone: return .init(.basicText)
            }
        case (.underline, .unselected):
            return .init(.gray04)
        default:
            break
        }
        
        // for flat, shadow
        switch (color, state) {
        case (_, .unselected):
            return .init(.gray04)
        case (.soft, .selected):
            return .init(.basicText)
        case (_, .selected):
            return .init(.white)
        }
    }
    
    func itemBorderColor(state: PickerState) -> UniversalColor {
        return .init(.clear)
    }
    
    func itemShadowColor(state: PickerState) -> UniversalColor {
        switch (variant, state) {
        case (.flat, _): return .init(.clear)
        case (.shadow, .selected): return .init(.black.opacity(0.2))
        case (.shadow, .unselected): return .init(.clear)
        case (.underline, _): return .init(.clear)
        }
    }
    
    func containerBackgroundColor() -> UniversalColor {
        switch variant {
        case .flat, .shadow:
            return .init(.gray02)
        case .underline:
            return .init(.basicBackground)
        }
    }
}
