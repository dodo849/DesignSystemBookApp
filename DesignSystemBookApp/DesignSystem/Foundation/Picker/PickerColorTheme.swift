//
//  ToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

protocol PickerColorTheme {
    func backgroundColor(state: PickerState) -> ColorOffset
    func foregroundColor(state: PickerState) -> ColorOffset
}
