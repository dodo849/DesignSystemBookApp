//
//  BasicRadioButtonTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct BasicRadioButtonTheme: ToggleButtonColorTheme {
    let color: BasicToggleButtonColor
    
    func backgroundColor(state: ToggleButtonState) -> Color {
        switch (state, color) {
        case (_, _): return .none
        }
    }
    
    func foregroundColor(state: ToggleButtonState) -> Color {
        switch (state, color) {
        case (.unchecked, _): return .none
        case (.checked, .primary): return .basicYellow
        case (.checked, .secondary): return .basicGreen
        case (.checked, .tertiary): return .basicPink
        }
    }
    
    func borderColor(state: ToggleButtonState) -> Color {
        switch (state, color) {
        case (_, .primary): return .basicYellow
        case (_, .secondary): return .basicGreen
        case (_, .tertiary): return .basicPink
        }
    }
}
