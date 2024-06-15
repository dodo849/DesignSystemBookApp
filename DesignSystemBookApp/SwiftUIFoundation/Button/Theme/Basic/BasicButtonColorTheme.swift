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
    
    func backgroundColor(state: ButtonState) -> Color {
        switch variant {
        case .fill:
            return fillBackgroundColor(state: state, color: color)
        case .outline:
            return .clear
        case .translucent:
            return translucentBackgroundColor(state: state, color: color)
        case .transparent:
            return state == .pressed ? .gray01.opacity(0.5) : .clear
        }
    }
    
    func foregroundColor(state: ButtonState) -> Color {
        switch variant {
        case .fill:
            return .white
        case .outline:
            return outlineForegroundColor(state: state, color: color)
        case .translucent:
            return translucentForegroundColor(state: state, color: color)
        case .transparent:
            return transparentForegroundColor(state: state, color: color)
        }
    }
    
    func borderColor(state: ButtonState) -> Color {
        switch variant {
        case .fill, .translucent:
            return .clear
        case .outline:
            return outlineBorderColor(state: state, color: color)
        case .transparent:
            return .clear
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
        case (.enabled, .destructive): return .red // FIXME: need new color
        case (.disabled, _): return .gray03
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .red
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
        case (.enabled, .destructive): return .red.opacity(0.2) // FIXME: need new color
        case (.disabled, _): return .gray01
        case (.pressed, .primary): return .basicYellowSoftDeep
        case (.pressed, .secondary): return .basicGreenSoftDeep
        case (.pressed, .tertiary): return .basicPinkSoftDeep
        case (.pressed, .destructive): return .red.opacity(0.2) // FIXME: need arRedDeepSoft
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
        case (.enabled, .destructive): return .red // FIXME: need new color
        case (.disabled, _): return .gray04
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .red // FIXME: need arRedDeep
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
        case (.enabled, .destructive): return .red
        case (.disabled, _): return .gray05
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .red // FIXME: need arRedDeep
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
        case (.enabled, .destructive): return .red
        case (.disabled, _): return .gray02
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .red // FIXME: need arRedDeep
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
        case (.enabled, .destructive): return .red // FIXME: need new color
        case (.disabled, _): return .gray02
        case (.pressed, .primary): return .basicYellowDeep
        case (.pressed, .secondary): return .basicGreenDeep
        case (.pressed, .tertiary): return .basicPinkDeep
        case (.pressed, .destructive): return .red // FIXME: need arRedDeep
        }
    }
}