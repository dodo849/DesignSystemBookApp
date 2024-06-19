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
    
    func backgroundColor(state: PickerState) -> ColorOffset {
        switch (color, state) {
        case (.primary, .selected): return .init(.basicYellow)
        case (.primary, .unselected): return .init(.gray02)
        case (.secondary, .selected): return .init(.basicGreen)
        case (.secondary, .unselected): return .init(.gray02)
        case (.tertiary, .selected): return .init(.basicPink)
        case (.tertiary, .unselected): return .init(.gray02)
        }
    }
    
    func foregroundColor(state: PickerState) -> ColorOffset {
        return .init(.basicText)
//        switch color {
//        case .success: return .init(.success)
//        case .warning: return .init(.basicYellow)
//        case .error: return .init(.destructive)
//        case .info: return .init(.basicText)
//        }
    }
}
