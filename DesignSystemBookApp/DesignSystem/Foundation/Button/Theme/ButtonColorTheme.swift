//
//  ButtonColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

protocol ButtonColorTheme {
    func foregroundColor(state: ButtonState) -> UniversalColor
    func backgroundColor(state: ButtonState) -> UniversalColor
    func borderColor(state: ButtonState) -> UniversalColor
}
