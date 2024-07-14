//
//  BasicCardColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import Foundation

struct BasicCardColorTheme: CardColorTheme {
    private let variant: BasicCardVariant
    private let color: BasicCardColor
    
    init(
        variant: BasicCardVariant,
        color: BasicCardColor
    ) {
        self.variant = variant
        self.color = color
    }
    
    func backgroundColor() -> UniversalColor {
        switch(variant, color) {
        case (.outline, _): return .init(.none)
        case (.translucent, .primary): return .init(.basicYellowSoft)
        case (.translucent, .secondary): return .init(.basicGreenSoft)
        case (.translucent, .tertiary): return .init(.basicPinkSoft)
        case (.translucent, .gray): return .init(.gray01)
        }
    }
    
    func borderColor() -> UniversalColor {
        switch(variant, color) {
        case (.outline, .primary): return .init(.basicYellow.opacity(0.5))
        case (.outline, .secondary): return .init(.basicGreen.opacity(0.5))
        case (.outline, .tertiary): return .init(.basicPink.opacity(0.5))
        case (.outline, .gray): return .init(.gray03)
        case (.translucent, _): return .init(.none)
        }
    }
}
