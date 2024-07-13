//
//  BasicTextFieldColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import Foundation

struct BasicTextFieldColorTheme: TextFieldColorTheme {
    let variant: BasicTextFieldVariant
    let color: BasicTextFieldColor
    
    func foregroundColor(state: TextFieldAllState) -> UniversalColor {
        switch state {
        case .disabled:
            return .init(.gray04)
        case .normal:
            return .init(.gray05)
        case .focused:
            return .init(.basicText)
        default:
            return .init(.basicText)
        }
    }
    
    func backgroundColor(state: TextFieldAllState) -> UniversalColor {
        switch variant {
        case .plain:
            return plainBackgroundColor(color, state)
        default:
            return .init(.none)
        }
    }
    
    func borderColor(state: TextFieldAllState) -> UniversalColor {
        switch variant {
        case .outlined:
            return borderColorWithLineVariant(color, state)
        default:
            return .init(.none)
        }
    }
    
    func bottomBorderColor(state: TextFieldAllState) -> UniversalColor {
        switch variant {
        case .underlined:
            return borderColorWithLineVariant(color, state)
        default:
            return .init(.none)
        }
    }
    
    func descriptionColor(state: TextFieldAllState) -> UniversalColor {
        switch state {
        case .success:
            return .init(.success)
        case .error:
            return .init(.destructive)
        default:
            return .init(.none)
        }
    }
}

extension BasicTextFieldColorTheme {
    func plainBackgroundColor(
        _ color: BasicTextFieldColor,
        _ state: TextFieldAllState
    ) -> UniversalColor {
        switch (color, state) {
        case (.primary, .normal): return .init(.gray03.opacity(0.2))
        case (.primary, .focused): return .init(.basicYellowSoft)
        case (.secondary, .normal): return .init(.gray03.opacity(0.2))
        case (.secondary, .focused): return .init(.basicGreenSoft)
        case (.tertiary, .normal): return .init(.gray03.opacity(0.2))
        case (.tertiary, .focused): return .init(.basicPinkSoft)
        case (.gray, .normal): return .init(.gray01)
        case (.gray, .focused): return .init(.gray02)
        case (_, .error): return .init(.destructive.opacity(0.2))
        case (_, .success): return .init(.success.opacity(0.2))
        default: return .init(.none)
        }
    }
    
    private func borderColorWithLineVariant(
        _ color: BasicTextFieldColor,
        _ state: TextFieldAllState
    ) -> UniversalColor {
        switch (color, state) {
        case (.primary, .normal): return .init(.basicYellow.opacity(0.4))
        case (.primary, .focused): return .init(.basicYellow)
        case (.secondary, .normal): return .init(.basicGreen.opacity(0.4))
        case (.secondary, .focused): return .init(.basicGreen)
        case (.tertiary, .normal): return .init(.basicPink.opacity(0.4))
        case (.tertiary, .focused): return .init(.basicPink)
        case (.gray, .normal): return .init(.gray03)
        case (.gray, .focused): return .init(.gray07)
        case (_, .disabled): return .init(.gray02)
        case (_, .error): return .init(.destructive)
        case (_, .success): return .init(.success)
        }
    }
}
