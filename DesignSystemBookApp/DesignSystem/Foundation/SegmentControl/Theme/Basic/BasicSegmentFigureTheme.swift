//
//  BasicToastFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

struct BasicSegmentFigureTheme: SegmentFigureTheme {
    private let variant: BasicSegmentVariant
    private let _shape: BasicSegmentShape
    
    init(
        variant: BasicSegmentVariant,
        shape: BasicSegmentShape
    ) {
        self.variant = variant
        self._shape = shape
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .round, .square:
            let round = itemRounded()
            return RoundedRectangle(cornerRadius: round.max).asAnyShape()
        case .pill:
            return Capsule().asAnyShape()
        }
    }
    
    func containerRounded() -> RoundedOffset {
        switch _shape {
        case .round: return .xlarge
        case .square: return .medium
        case .pill: return .infinity
        }
    }
    
    func containerPadding() -> GapOffset {
        return .init(8, 8)
    }
    
    func itemRounded() -> RoundedOffset {
        if variant == .underline {
            return .zero
        }
        
        switch _shape {
        case .round: return .medium
        case .square: return .xsmall
        case .pill: return .infinity
        }
    }
    
    func itemPadding() -> GapOffset {
        return .init(8, 28)
    }
    
    func itemSpacing() -> GapOffset {
        return .init(all: 8)
    }
    
    func indicatorHeight() -> CGFloat? {
        switch variant {
        case .underline: return 3
        default: return nil
        }
    }
}
