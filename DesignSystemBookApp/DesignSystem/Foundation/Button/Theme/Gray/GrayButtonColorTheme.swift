//
//  GrayButtonColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import SwiftUI

struct GrayButtonColorTheme: ButtonColorTheme {
    private let variant: BasicButtonVariant
    private let color: GrayButtonColor
    
    init(variant: BasicButtonVariant, color: GrayButtonColor) {
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
            return .init(.basicBackground)
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

private extension GrayButtonColorTheme {
    func fillBackgroundColor(
        state: ButtonState,
        color: GrayButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .stone): return .gray06
        case (.enabled, .mute): return .gray04
        case (.enabled, .ghost): return .gray03
        case (.disabled, _): return .gray02
        case (.pressed, .stone): return .gray07
        case (.pressed, .mute): return .gray05
        case (.pressed, .ghost): return .gray04
        }
    }
    
    func translucentBackgroundColor(
        state: ButtonState,
        color: GrayButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .stone): return .gray06.opacity(0.5)
        case (.enabled, .mute): return .gray04.opacity(0.5)
        case (.enabled, .ghost): return .gray03.opacity(0.5)
        case (.disabled, _): return .gray01
        case (.pressed, .stone): return .gray06.opacity(0.7)
        case (.pressed, .mute): return .gray04.opacity(0.7)
        case (.pressed, .ghost): return .gray03.opacity(0.7)
        }
    }

    func outlineForegroundColor(
        state: ButtonState,
        color: GrayButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .stone): return .gray06
        case (.enabled, .mute): return .gray04
        case (.enabled, .ghost): return .gray03
        case (.disabled, _): return .gray03
        case (.pressed, .stone): return .gray07
        case (.pressed, .mute): return .gray05
        case (.pressed, .ghost): return .gray04
        }
    }

    func translucentForegroundColor(
        state: ButtonState,
        color: GrayButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .stone): return .gray06
        case (.enabled, .mute): return .gray04
        case (.enabled, .ghost): return .gray03
        case (.disabled, _): return .gray03
        case (.pressed, .stone): return .gray07
        case (.pressed, .mute): return .gray05
        case (.pressed, .ghost): return .gray04
        }
    }

    func transparentForegroundColor(
        state: ButtonState,
        color: GrayButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .stone): return .gray06
        case (.enabled, .mute): return .gray05
        case (.enabled, .ghost): return .gray03
        case (.disabled, _): return .gray03
        case (.pressed, .stone): return .gray07
        case (.pressed, .mute): return .gray06
        case (.pressed, .ghost): return .gray04
        }
    }

    func outlineBorderColor(
        state: ButtonState,
        color: GrayButtonColor
    ) -> Color {
        switch (state, color) {
        case (.enabled, .stone): return .gray06
        case (.enabled, .mute): return .gray04
        case (.enabled, .ghost): return .gray03
        case (.disabled, _): return .gray03
        case (.pressed, .stone): return .gray07
        case (.pressed, .mute): return .gray05
        case (.pressed, .ghost): return .gray04
        }
    }
}
