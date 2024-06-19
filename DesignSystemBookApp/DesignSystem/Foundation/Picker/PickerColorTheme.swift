//
//  ToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

protocol PickerColorTheme {
    func itemBackgroundColor(state: PickerState) -> ColorOffset
    func itemForegroundColor(state: PickerState) -> ColorOffset
    func containerBackgroundColor() -> ColorOffset
}
