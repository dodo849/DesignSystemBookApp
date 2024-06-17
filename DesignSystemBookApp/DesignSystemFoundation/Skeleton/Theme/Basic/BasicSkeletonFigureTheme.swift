//
//  BasicSkeletonFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct BasicSkeletonFigureTheme: SkeletonFigureTheme {
    private let state: SkeletonState
    private let _shape: SkeletonShape
    init(
        state: SkeletonState,
        shape: SkeletonShape
    ) {
        self.state = state
        self._shape = shape
    }
    
    func rounded() -> RoundedOffset {
        return .small
    }
    
    func shape() -> AnyShape? {
        if state == .complete {
            return nil
        }
        
        switch _shape {
        case .none:
            return nil
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
        case .circle:
            return Circle().asAnyShape()
        }
    }
}
