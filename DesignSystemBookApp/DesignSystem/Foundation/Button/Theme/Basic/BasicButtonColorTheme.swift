//
//  GrayButtonColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct BasicButtonColorTheme: ButtonColorTheme {
    private let variant: BasicButtonVariant
    private let color: BasicButtonColor
    
    init(variant: BasicButtonVariant, color: BasicButtonColor) {
        self.variant = variant
        self.color = color
    }
    
    func backgroundColor(state: ButtonState) -> UniversalColor {
        switch variant {
        case .fill:
            return .init(fillBackgroundColor(state: state, color: color))
        case .outline:
            return .init(.none)
        case .translucent:
            return .init(translucentBackgroundColor(state: state, color: color))
        case .transparent:
            return .init(state == .pressed ? .gray01.opacity(0.5) : .none)
        }
    }
    
    func foregroundColor(state: ButtonState) -> UniversalColor {
        switch variant {
        case .fill:
            return .init(.white)
        case .outline:
            return .init(outlineForegroundColor(state: state, color: color))
        case .translucent:
            return .init(translucentForegroundColor(state: state, color: color))
        case .transparent:
            return .init(transparentForegroundColor(state: state, color: color))
        }
    }
    
    func borderColor(state: ButtonState) -> UniversalColor {
        switch variant {
        case .fill, .translucent:
            return .init(.none)
        case .outline:
            return .init(outlineBorderColor(state: state, color: color))
        case .transparent:
            return .init(.none)
        }
    }
}

private extension BasicButtonColorTheme {
    func fillBackgroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .primary): return .basicYellow
        case (.enabled, .secondary): return .basicGreen
        case (.enabled, .tertiary): return .basicPink
        case (.enabled, .destructive): return .destructive
        case (.disabled, _): return .gray03
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .destructive
        }
    }
    
    func translucentBackgroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .primary): return .basicYellowSoft
        case (.enabled, .secondary): return .basicGreenSoft
        case (.enabled, .tertiary): return .basicPinkSoft
        case (.enabled, .destructive): return .destructiveSoft
        case (.disabled, _): return .gray01
        case (.pressed, .primary): return .basicYellowSoftDeep
        case (.pressed, .secondary): return .basicGreenSoftDeep
        case (.pressed, .tertiary): return .basicPinkSoftDeep
        case (.pressed, .destructive): return .destructiveSoft
        }
    }
    
    func outlineForegroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .primary): return .basicYellow
        case (.enabled, .secondary): return .basicGreen
        case (.enabled, .tertiary): return .basicPink
        case (.enabled, .destructive): return .destructive
        case (.disabled, _): return .gray04
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .destructive
        }
    }
    
    func translucentForegroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .primary): return .basicYellow
        case (.enabled, .secondary): return .basicGreen
        case (.enabled, .tertiary): return .basicPink
        case (.enabled, .destructive): return .destructive
        case (.disabled, _): return .gray05
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .destructive
        }
    }
    
    func transparentForegroundColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .primary): return .basicYellow
        case (.enabled, .secondary): return .basicGreen
        case (.enabled, .tertiary): return .basicPink
        case (.enabled, .destructive): return .destructive
        case (.disabled, _): return .gray02
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .destructive
        }
    }
    
    func outlineBorderColor(
        state: ButtonState,
        color: BasicButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .primary): return .basicYellow
        case (.enabled, .secondary): return .basicGreen
        case (.enabled, .tertiary): return .basicPink
        case (.enabled, .destructive): return .destructive
        case (.disabled, _): return .gray02
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .destructive
        }
    }
}
