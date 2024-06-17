//
//  ButtonColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

protocol ButtonColorTheme {
    func foregroundColor(state: ButtonState) -> Color
    func backgroundColor(state: ButtonState) -> Color
    func borderColor(state: ButtonState) -> Color
}
