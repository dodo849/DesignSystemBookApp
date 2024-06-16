//
//  BasicTextFieldColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

extension Color {
    // for animation
    static let transparent = white.opacity(0)
}

struct BasicTextFieldColorTheme: TextFieldColorTheme {
    let variant: BasicTextFieldVariant
    let color: BasicTextFieldColor
    
    func foregroundColor(state: TextFieldAllState) -> Color {
        switch state {
        case .disabled:
            return .gray04
        default:
            return .basicText
        }
    }
    
    func backgroundColor(state: TextFieldAllState) -> Color {
        switch variant {
        case .plain:
            return plainBackgroundColor(color, state)
        default:
            return .none
        }
    }
    
    func borderColor(state: TextFieldAllState) -> Color {
        switch variant {
        case .outlined, .underlined:
            return borderColorWithLineVariant(color, state)
        default:
            return .none
        }
    }
}

extension BasicTextFieldColorTheme {
    func plainBackgroundColor(
        _ color: BasicTextFieldColor,
        _ state: TextFieldAllState
    ) -> Color {
        switch (color, state) {
        case (.primary, .normal): return .gray03.opacity(0.2) // Using opacity due to animation
        case (.primary, .focused): return .basicYellowSoft
        case (.secondary, .normal): return .gray03.opacity(0.2)
        case (.secondary, .focused): return .basicGreenSoft
        case (.tertiary, .normal): return .gray03.opacity(0.2)
        case (.tertiary, .focused): return .basicPinkSoft
        case (.gray, .normal): return .none
        case (.gray, .focused): return .gray01
        case (_, .error): return .destructive.opacity(0.2)
        case (_, .success): return .success.opacity(0.2)
        default: return .none
        }
    }
    
    private func borderColorWithLineVariant(
        _ color: BasicTextFieldColor,
        _ state: TextFieldAllState
    ) -> Color {
        switch (color, state) {
        case (.primary, .normal): return .basicYellow.opacity(0.4)
        case (.primary, .focused): return .basicYellow
        case (.secondary, .normal): return .basicGreen.opacity(0.4)
        case (.secondary, .focused): return .basicGreen
        case (.tertiary, .normal): return .basicPink.opacity(0.4)
        case (.tertiary, .focused): return .basicPink
        case (.gray, .normal): return .gray03
        case (.gray, .focused): return .gray07
        case (_, .disabled): return .gray02
        case (_, .error): return .destructive
        case (_, .success): return .success
        }
    }
}
