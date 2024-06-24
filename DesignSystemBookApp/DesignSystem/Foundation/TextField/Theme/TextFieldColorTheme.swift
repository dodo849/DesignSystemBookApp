//
//  TextFieldColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

protocol TextFieldColorTheme {
    func foregroundColor(state: TextFieldAllState) -> ColorOffset
    func backgroundColor(state: TextFieldAllState) -> ColorOffset
    func borderColor(state: TextFieldAllState) -> ColorOffset
    func bottomBorderColor(state: TextFieldAllState) -> ColorOffset
}
