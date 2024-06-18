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
        switch _shape {
            
        case .none: return .zero
        case .round: return .large
        case .square: return .extraSmall
        case .pill: return .infinity
        case .circle: return .infinity
        }
    }
    
    func shape() -> AnyShape? {
        if state == .complete {
            return nil
        }
        
        switch _shape {
        case .none:
            return nil
        case .round, .square:
            let offset = rounded()
            return RoundedRectangle(cornerRadius: offset.max).asAnyShape()
        case .pill:
            return Capsule().asAnyShape()
        case .circle:
            return Circle().asAnyShape()
        }
    }
}
