//
//  BasicToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import Foundation

struct BasicSegmentColorTheme: PickerColorTheme {
    private let color: SegmentColor
    
    init(color: SegmentColor) {
        self.color = color
    }
    
    func itemBackgroundColor(state: PickerState) -> ColorOffset {
        switch (color, state) {
        case (.primary, .selected): return .init(.basicYellow)
        case (.primary, .unselected): return .init(.gray02)
        case (.secondary, .selected): return .init(.basicGreen)
        case (.secondary, .unselected): return .init(.gray02)
        case (.tertiary, .selected): return .init(.basicPink)
        case (.tertiary, .unselected): return .init(.gray02)
        }
    }
    
    func itemForegroundColor(state: PickerState) -> ColorOffset {
        switch (color, state) {
        case (_, .unselected): return .init(.gray04)
        case (_, .selected): return .init(.white)
//        case (.primary, .selected): return .init(.basicYellow)
//        case (.secondary, .selected): return .init(.basicGreen)
//        case (.tertiary, .selected): return .init(.basicPink)
        }
    }
    
    func containerBackgroundColor() -> ColorOffset {
        return .init(.gray01)
    }
}
