//
//  BasicToastFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

struct BasicSegmentFigureTheme: PickerFigureTheme {
    private let _shape: BasicSegmentShape
    
    init(shape: BasicSegmentShape) {
        self._shape = shape
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .round:
            let round = itemRounded()
            return RoundedRectangle(cornerRadius: round.max).asAnyShape()
        case .square:
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
        return .init(6, 12)
    }
    
    func itemRounded() -> RoundedOffset {
        switch _shape {
        case .round: return .medium
        case .square: return .xsmall
        case .pill: return .infinity
        }
    }
    
    func itemPadding() -> GapOffset {
        return .init(10, 28)
    }
    
    func itemSpacing() -> GapOffset {
        return .init(all: 8)
    }
    
}
