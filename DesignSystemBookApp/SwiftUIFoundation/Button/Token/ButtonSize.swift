//
//  ButtonSize.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public enum ButtonSize: String, CaseIterable {
    case large, medium, small
}

extension ButtonSize {
    var textSize: CGFloat {
        switch self {
        case .large: 18
        case .medium: 16
        case .small: 12
        }
    }
    
    var textWeight: Font.Weight {
        switch self {
        case .large: .semibold
        case .medium: .medium
        case .small: .regular
        }
    }
    
    var padding: Spacing {
        switch self {
        case .large: .init(16, 32)
        case .medium: .init(10, 24)
        case .small: .init(8, 16)
        }
    }
    
    var rounded: CGFloat {
        switch self {
        case .large: 16
        case .medium: 12
        case .small: 8
        }
    }
    
    var width: CGFloat? {
        switch self {
        case .large: .infinity
        case .medium: nil
        case .small: nil
        }
    }
    
    struct Spacing {
        let vertical: CGFloat
        let horizontal: CGFloat
        
        init(
            _ vertical: CGFloat = .zero,
            _ horizontal: CGFloat = .zero
        ) {
            self.vertical = vertical
            self.horizontal = horizontal
        }
    }
}
