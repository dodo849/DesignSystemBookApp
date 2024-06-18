//
//  ButtonColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

protocol ButtonColorTheme {
    func foregroundColor(state: ButtonState) -> ColorOffset
    func backgroundColor(state: ButtonState) -> ColorOffset
    func borderColor(state: ButtonState) -> ColorOffset
}
