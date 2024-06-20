//
//  BasicToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import Foundation

struct BasicSegmentColorTheme: PickerColorTheme {
    private let color: BasicSegmentColor
    
    init(color: BasicSegmentColor) {
        self.color = color
    }
    
    func itemBackgroundColor(state: PickerState) -> ColorOffset {
        switch (color, state) {
        case (_, .unselected): return .init(.gray03)
        case (.primary, .selected): return .init(.basicYellow)
        case (.secondary, .selected): return .init(.basicGreen)
        case (.tertiary, .selected): return .init(.basicPink)
        case (.soft, .selected): return .init(.basicBackground)
        case (.stone, .selected): return .init(.gray05)
        }
    }
    
    func itemForegroundColor(state: PickerState) -> ColorOffset {
        switch (color, state) {
        case (_, .unselected): return .init(.gray04)
        case (.soft, .selected): return .init(.basicText)
        case (_, .selected): return .init(.white)
        }
    }
    
    func containerBackgroundColor() -> ColorOffset {
        return .init(.gray02)
    }
}
