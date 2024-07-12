//
//  TextFieldColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

protocol TextFieldColorTheme {
    func foregroundColor(state: TextFieldAllState) -> UniversalColor
    func backgroundColor(state: TextFieldAllState) -> UniversalColor
    func borderColor(state: TextFieldAllState) -> UniversalColor
    func bottomBorderColor(state: TextFieldAllState) -> UniversalColor
}
