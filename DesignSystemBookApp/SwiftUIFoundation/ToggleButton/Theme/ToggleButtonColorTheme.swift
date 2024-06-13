//
//  ToggleButtonTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

protocol ToggleButtonColorTheme {
    func foregroundColor(state: ToggleButtonState) -> Color
    func backgroundColor(state: ToggleButtonState) -> Color
    func borderColor(state: ToggleButtonState) -> Color
}
