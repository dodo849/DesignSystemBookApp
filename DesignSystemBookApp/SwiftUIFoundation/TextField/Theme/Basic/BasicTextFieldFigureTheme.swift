//
//  BasicTextFieldFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

struct BasicTextFieldFigureTheme: TextFieldFigureTheme {
    private let size: BasicTextFieldSize
    private let _shape: BasicTextFieldShape
    
    init(
        size: BasicTextFieldSize,
        shape: BasicTextFieldShape
    ) {
        self.size = size
        self._shape = shape
    }
    
    func padding() -> GapOffset {
        switch size {
        case .large: .init(16, 32)
        case .medium: .init(10, 24)
        case .small: .init(8, 16)
        }
    }
    
    func textSize() -> CGFloat {
        return 16
    }
    
    func textWeight() -> Font.Weight {
        return .regular
    }
    
    func rounded() -> RoundedOffset {
        return .init(all: 16)
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
        case .square:
            return RoundedRectangle(cornerRadius: 0).asAnyShape()
        case .round:
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
