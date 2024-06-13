//
//  BasicCheckboxTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct BasicCheckboxTheme: CheckboxTheme {
    let color: CheckboxColor
    
    func backgroundColor(state: CheckboxState) -> Color {
        switch (state, color) {
        case (.unchecked, _): return .clear
        case (.checked, .primary): return .basicYellow
        case (.checked, .secondary): return .basicGreen
        case (.checked, .tertiary): return .basicPink
        }
    }
    
    func foregroundColor(state: CheckboxState) -> Color {
        switch (state, color) {
        case (.unchecked, _): return .clear
        case (.checked, _): return .white
        }
    }
    
    func borderColor(state: CheckboxState) -> Color {
        switch (state, color) {
        case (_, .primary): return .basicYellow
        case (_, .secondary): return .basicGreen
        case (_, .tertiary): return .basicPink
        }
    }
}
