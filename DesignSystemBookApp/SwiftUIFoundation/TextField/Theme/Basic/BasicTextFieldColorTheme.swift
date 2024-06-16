//
//  BasicTextFieldColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

struct BasicTextFieldColorTheme: TextFieldColorTheme {
    let variant: BasicTextFieldVariant
    let color: BasicTextFieldColor
    
    func foregroundColor(state: TextFieldAllState) -> Color {
        return .basicText
    }
    
    func backgroundColor(state: TextFieldAllState) -> Color {
        switch (variant, color, state) {
        case (.gray, _, _): return .gray01
        case (_, _, .disabled): return .gray01
        default: return .clear
        }
    }
    
    func borderColor(state: TextFieldAllState) -> Color {
        switch variant {
        case .outlined, .underlined:
            return borderColorWithLineVariant(color, state)
        default:
            return .clear
        }
    }
}

extension BasicTextFieldColorTheme {
    private func borderColorWithLineVariant(
        _ color: BasicTextFieldColor,
        _ state: TextFieldAllState
    ) -> Color {
        switch (color, state) {
        case (.primary, .normal): return .basicYellowSoft
        case (.primary, .focused): return .basicYellow
        case (.primary, .disabled): return .gray02
        case (.secondary, _): return .basicGreenSoft
        case (.tertiary, _): return .basicPinkSoft
        case (_, .error): return .destructive
        case (_, .success): return .success
        default: return .clear
        }
    }
}
