//
//  BasicTextFieldFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

struct BasicTextFieldFigureTheme: TextFieldFigureTheme {
    private let variant: BasicTextFieldVariant
    private let size: BasicTextFieldSize
    private let _shape: BasicTextFieldShape
    
    init(
        variant: BasicTextFieldVariant,
        size: BasicTextFieldSize,
        shape: BasicTextFieldShape
    ) {
        self.variant = variant
        self.size = size
        self._shape = shape
    }
    
    func padding() -> GapOffset {
        if variant == .underlined {
            switch size {
            case .large: return .init(16, 0)
            case .medium: return .init(10, 0)
            case .small: return .init(8, 0)
            }
        }
        
        switch size {
        case .large: return .init(16, 24)
        case .medium: return .init(10, 20)
        case .small: return .init(8, 16)
        }
    }
    
    func textSize() -> CGFloat {
        switch size {
        case .large: 16
        case .medium: 16
        case .small: 14
        }
    }
    
    func textWeight() -> Font.Weight {
        return .regular
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
        }
    }
    
    func borderWidth() -> CGFloat {
        return 1
    }
    
    func frame() -> FrameOffset {
        return .init(.infinity, nil)
    }
    
    func shape() -> AnyShape {
        let offset = rounded()
        switch _shape {
        case .square, .round:
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
}
