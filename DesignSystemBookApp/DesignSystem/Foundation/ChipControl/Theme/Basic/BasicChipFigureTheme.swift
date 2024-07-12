//
//  BasicChipFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

struct BasicChipFigureTheme: ChipFigureTheme {
    private let _shape: BasicChipShape
    
    init(shape: BasicChipShape) {
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
    
    /// Not used
    func containerRounded() -> RoundedOffset {
        return .init(all: 0)
    }
    
    /// Not used
    func containerPadding() -> GapOffset {
        return .init(all: 0)
    }
    
    func itemRounded() -> RoundedOffset {
        switch _shape {
        case .round: return .medium
        case .square: return .xsmall
        case .pill: return .infinity
        }
    }
    
    func itemPadding() -> GapOffset {
        return .init(8, 16)
    }
    
    func itemSpacing() -> GapOffset {
        return .init(all: 8)
    }
}
