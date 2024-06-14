//
//  BasicToggleButtonFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import SwiftUI

struct BasicToggleButtonFigureTheme: ToggleButtonFigureTheme {
    private let _shape: BasicToggleButtonShape
    
    init(shape: BasicToggleButtonShape) {
        self._shape = shape
    }
    
    func innnerImageSize() -> FrameOffset {
        switch _shape {
        case .round: return .init(all: 12)
        case .square: return .init(all: 12)
        case .circle: return .init(all: 10)
        }
    }
    
    func padding() -> GapOffset {
        switch _shape {
        case .round: return .init(all: 4)
        case .square: return .init(all: 4)
        case .circle: return .init(all: 5)
        }
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .square:
            return RoundedRectangle(cornerRadius: 0).asAnyShape()
        case .round:
            return RoundedRectangle(cornerRadius: 4).asAnyShape()
        case .circle:
            return Circle().asAnyShape()
        }
    }
}
