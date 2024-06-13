//
//  CheckboxTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

protocol CheckboxTheme {
    func foregroundColor(state: CheckboxState) -> Color
    func backgroundColor(state: CheckboxState) -> Color
    func borderColor(state: CheckboxState) -> Color
}
