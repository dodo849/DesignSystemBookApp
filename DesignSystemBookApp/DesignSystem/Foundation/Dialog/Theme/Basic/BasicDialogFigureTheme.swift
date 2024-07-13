//
//  BasicDialogFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/3/24.
//

import SwiftUI

struct BasicDialogFigureTheme: DialogFigureTheme {
    private var _shape: BasicDialogShape
    
    init(shape: BasicDialogShape) {
        self._shape = shape
    }
    
    func padding() -> GapOffset {
        return .init(28, 24)
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .round:
            let round = rounded()
            return RoundedRectangle(cornerRadius: round.max).asAnyShape()
        case .square:
            let round = rounded()
            return RoundedRectangle(cornerRadius: round.max).asAnyShape()
        }
    }
    
    func rounded() -> RoundedOffset {
        switch _shape {
        case .round: return .xlarge
        case .square: return .xsmall
        }
    }
}
