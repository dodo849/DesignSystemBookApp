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
        case .xsmall: .init(4, 4)
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
        switch size {
        case .large: .init(all: 16)
        case .medium: .init(all: 12)
        case .small: .init(all: 8)
        case .xsmall: .init(all: 6)
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
        case .square:
            return Rectangle().asAnyShape()
        case .round:
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
}