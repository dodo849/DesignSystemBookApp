//
//  ToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

// TODO: itemBackgroundColor보단 indicator color가 맞는데 이게 picker에 제너럴한지 고민
protocol PickerColorTheme {
    func itemBackgroundColor(state: PickerState) -> ColorOffset
    func itemForegroundColor(state: PickerState) -> ColorOffset
    func itemShadowColor(state: PickerState) -> ColorOffset
    func containerBackgroundColor() -> ColorOffset
}
