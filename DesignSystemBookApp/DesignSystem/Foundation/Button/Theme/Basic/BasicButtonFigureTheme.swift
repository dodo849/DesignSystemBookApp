//
//  BasicButtonFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import SwiftUI

struct BasicButtonFigureTheme: ButtonFigureTheme {
    private let size: BasicButtonSize
    private let _shape: BasicButtonShape
    
    init(size: BasicButtonSize, shape: BasicButtonShape) {
        self.size = size
        self._shape = shape
    }
    
    func padding() -> GapOffset {
        switch size {
        case .large: .init(16, 32)
        case .medium: .init(10, 24)
        case .small: .init(8, 16)
        case .xsmall: .init(6, 8)
        }
    }
    
    func typo() -> Typo {
        switch size {
        case .large: .body0b
        case .medium: .body1b
        case .small, .xsmall: .body2
        }
    }
    
    func textSize() -> CGFloat {
        switch size {
        case .large: 18
        case .medium: 16
        case .small, .xsmall: 12
        }
    }
    
    func textWeight() -> Font.Weight {
        switch size {
        case .large: .semibold
        case .medium: .medium
        case .small, .xsmall: .regular
        }
    }
    
    func rounded() -> RoundedOffset {
        if _shape == .square {
            return .extraSmall
        }
        
        if _shape == .pill {
            return .init(all: .infinity)
        }
        
        switch size {
        case .large: return .large
        case .medium: return .medium
        case .small: return .small
        case .xsmall: return .xsmall
        }
    }
    func borderWidth() -> CGFloat {
        return 1
    }
    
    func frame() -> FrameOffset {
        switch size {
        case .large: .init(.infinity, nil)
        case .medium, .small, .xsmall: .init(nil, nil)
        }
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .square, .round:
            let offset = rounded()
            return IndividualRoundedRectangle(
                topLeftRadius: offset.topLeftRadius,
                topRightRadius: offset.topRightRadius,
                bottomLeftRadius: offset.bottomLeftRadius,
                bottomRightRadius: offset.bottomRightRadius
            ).asAnyShape()
        case .pill:
            return Capsule().asAnyShape()
        }
    }
    
    func iconSize() -> FrameOffset {
        switch size {
        case .large:
            return .init(22, 22)
        case .medium:
            return .init(18, 18)
        case .small:
            return .init(16, 16)
        case .xsmall:
            return .init(16, 16)
        }
    }
}
