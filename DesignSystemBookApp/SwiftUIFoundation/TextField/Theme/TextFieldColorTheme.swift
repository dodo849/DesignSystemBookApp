//
//  TextFieldColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

protocol TextFieldColorTheme {
    func foregroundColor(state: TextFieldState) -> Color
    func backgroundColor(state: TextFieldState) -> Color
    func borderColor(state: TextFieldState) -> Color
}
