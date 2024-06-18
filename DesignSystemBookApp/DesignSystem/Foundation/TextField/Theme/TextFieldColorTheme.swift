//
//  TextFieldColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

protocol TextFieldColorTheme {
    func foregroundColor(state: TextFieldAllState) -> Color
    func backgroundColor(state: TextFieldAllState) -> Color
    func borderColor(state: TextFieldAllState) -> Color
}
