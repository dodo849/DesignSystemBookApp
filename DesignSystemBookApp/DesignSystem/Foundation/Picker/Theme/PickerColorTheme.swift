//
//  ToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

protocol PickerColorTheme {
    func itemBackgroundColor(state: PickerState) -> UniversalColor
    func itemForegroundColor(state: PickerState) -> UniversalColor
    func itemShadowColor(state: PickerState) -> UniversalColor
    func itemBorderColor(state: PickerState) -> UniversalColor
    func containerBackgroundColor() -> UniversalColor
}
