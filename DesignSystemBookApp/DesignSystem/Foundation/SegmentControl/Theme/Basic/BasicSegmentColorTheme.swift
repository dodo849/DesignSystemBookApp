//
//  BasicToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import Foundation

struct BasicSegmentColorTheme: SegmentColorTheme {
    private let variant: BasicSegmentVariant
    private let color: BasicSegmentColor
    
    init(
        variant: BasicSegmentVariant,
        color: BasicSegmentColor
    ) {
        self.variant = variant
        self.color = color
    }
    
    func itemForegroundColor(state: SegmentState) -> UniversalColor {
        // for underline
        switch (variant, state) {
        case (.underline, .selected):
            return underlineItemForegroundColor()
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
    
    func indicatorBackgroundColor() -> UniversalColor {
        switch color {
        case .primary: return .init(.basicYellow)
        case .secondary: return .init(.basicGreen)
        case .tertiary: return .init(.basicPink)
        case .soft: return .init(.basicBackground)
        case .stone: return .init(.gray05)
        }
    }
    
    func indicatorShadow() -> UniversalColor {
        switch variant {
        case .flat: return .init(.clear)
        case .shadow: return .init(.black.opacity(0.2))
        case .underline: return .init(.clear)
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

extension BasicSegmentColorTheme {
    func underlineItemForegroundColor() -> UniversalColor {
        switch color {
        case .primary: return .init(.basicYellow)
        case .secondary: return .init(.basicGreen)
        case .tertiary: return .init(.basicPink)
        case .soft: return .init(.basicText)
        case .stone: return .init(.basicText)
        }
    }
}
